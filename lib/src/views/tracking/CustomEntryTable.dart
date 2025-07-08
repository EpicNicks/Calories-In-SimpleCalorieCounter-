import 'package:calorie_tracker/src/dto/CustomSymbolEntry.dart';
import 'package:calorie_tracker/src/dto/FoodItemEntry.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n/app_localizations.dart';

class CustomEntryTable extends StatefulWidget {
  @override
  State<CustomEntryTable> createState() => _CustomEntryTableState();
}

class _CustomEntryTableState extends State<CustomEntryTable> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<CustomSymbolEntry> _symbols = [];
  bool _isLoading = true;
  String? _errorMessage;

  final _nameController = TextEditingController();
  final _expressionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Add these focus nodes to maintain focus state
  final _nameFocusNode = FocusNode();
  final _expressionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadSymbols();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _expressionController.dispose();
    _nameFocusNode.dispose();
    _expressionFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadSymbols() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final symbols = await _databaseHelper.getAllUserSymbols();
      setState(() {
        _symbols = symbols;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = AppLocalizations.of(context)!.symbolTableLoadingFailure;
        _isLoading = false;
      });
    }
  }

  // Async validation helper function
  Future<String?> _validateExpression(String? expression) async {
    if (expression == null || expression.trim().isEmpty) {
      return AppLocalizations.of(context)!.symbolTableExpressionRequiredError;
    }

    try {
      final result = await evaluateFoodItemNoComment(expression);
      if (result <= 0) {
        return AppLocalizations.of(context)!.symbolExpressionPositiveConstraintFailure;
      }
      return null; // Valid
    } catch (e) {
      return 'Invalid expression: ${e.toString()}';
    }
  }

  Future<void> _addSymbol() async {
    final name = _nameController.text.trim();
    final expression = _expressionController.text.trim();

    // Manual validation without calling form validate
    if (name.isEmpty) {
      _showErrorSnackBar(AppLocalizations.of(context)!.symbolTableNameRequiredError);
      return;
    }

    if (expression.isEmpty) {
      _showErrorSnackBar(AppLocalizations.of(context)!.symbolTableExpressionRequiredError);
      return;
    }

    // Perform async validation
    final expressionError = await _validateExpression(expression);
    if (expressionError != null) {
      _showErrorSnackBar(expressionError);
      return;
    }

    try {
      final newSymbol = CustomSymbolEntry(name: name.replaceAll(" ", "_"), expression: expression);
      final result = await _databaseHelper.addUserSymbol(newSymbol);

      if (result == 0) {
        // Duplicate name constraint violation
        _showErrorSnackBar(AppLocalizations.of(context)!.symbolTableNameExistsError(name));
        return;
      }

      _nameController.clear();
      _expressionController.clear();
      await _loadSymbols();
    } catch (e) {
      if (e.toString().contains('UNIQUE constraint failed')) {
        _showErrorSnackBar(AppLocalizations.of(context)!.symbolTableNameExistsError(name));
      }
    }
  }

  Future<void> _deleteSymbol(CustomSymbolEntry symbol) async {
    try {
      await _databaseHelper.deleteUserSymbol(symbol.id!);
      await _loadSymbols();
    } catch (e) {}
  }

  Future<void> _editSymbol(CustomSymbolEntry symbol) async {
    final nameController = TextEditingController(text: symbol.name);
    final expressionController = TextEditingController(text: symbol.expression);
    final editFormKey = GlobalKey<FormState>();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Form(
              key: editFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.symbolTableNameColumnHeader,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.symbolTableNameRequiredError;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: expressionController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.symbolTableExpressionColumnHeader,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.symbolTableExpressionRequiredError;
                      }
                      // Basic synchronous validation only
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Validate form first
                if (!editFormKey.currentState!.validate()) {
                  return;
                }

                final name = nameController.text.trim();
                final expression = expressionController.text.trim();

                // Perform async validation
                final expressionError = await _validateExpression(expression);
                if (expressionError != null) {
                  _showErrorSnackBar(expressionError);
                  return;
                }

                try {
                  final updatedSymbol = CustomSymbolEntry(
                    id: symbol.id,
                    name: name,
                    expression: expression,
                  );

                  await _databaseHelper.updateUserSymbol(updatedSymbol);
                  Navigator.of(context).pop();
                  await _loadSymbols();
                } catch (e) {
                  if (e.toString().contains('UNIQUE constraint failed')) {
                    _showErrorSnackBar(AppLocalizations.of(context)!.symbolTableNameExistsError(name));
                  }
                }
              },
              child: Text(AppLocalizations.of(context)!.updateButton),
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _confirmDelete(CustomSymbolEntry symbol) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(AppLocalizations.of(context)!.symbolTableConfirmDelete(symbol.name)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancelButton),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteSymbol(symbol);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(AppLocalizations.of(context)!.deleteButton),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.symbolTableMenu),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            Text(
              localizations.symbolTableDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 8),
            Text(
              localizations.symbolTableDescriptionExtended,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
            ),
            SizedBox(height: 24),

            // Add new symbol form
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        decoration: InputDecoration(
                          labelText: localizations.symbolTableNameColumnHeader,
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _expressionController,
                        focusNode: _expressionFocusNode,
                        decoration: InputDecoration(
                          labelText: localizations.symbolTableExpressionColumnHeader,
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    IconButton(onPressed: _addSymbol, icon: Icon(Icons.add)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Symbols table
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, size: 48, color: Colors.red),
                              SizedBox(height: 16),
                              Text(_errorMessage!),
                              SizedBox(height: 16),
                              IconButton(
                                onPressed: _loadSymbols,
                                icon: Icon(Icons.replay_outlined),
                              ),
                            ],
                          ),
                        )
                      : _symbols.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.list_alt, size: 48, color: Colors.grey),
                                  SizedBox(height: 16),
                                  Text(AppLocalizations.of(context)!.symbolExpressionNoneDefinedHint1),
                                  Text(AppLocalizations.of(context)!.symbolExpressionNoneDefinedHint2),
                                ],
                              ),
                            )
                          : Card(
                              child: ListView.builder(
                                itemCount: _symbols.length,
                                itemBuilder: (context, index) {
                                  final symbol = _symbols[index];
                                  return ListTile(
                                    title: Text(
                                      "${symbol.name}${isConstant(symbol.expression) ? '' : ' (=${evaluateFoodItemNoCommentWithSymbols(symbol.expression, _symbols.where((s) => s != symbol).toList()).toInt()})'}",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(symbol.expression),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () => _editSymbol(symbol),
                                          tooltip: 'Edit',
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () => _confirmDelete(symbol),
                                          tooltip: 'Delete',
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
