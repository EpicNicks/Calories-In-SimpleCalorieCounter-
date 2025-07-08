import 'package:calorie_tracker/src/dto/CustomSymbolEntry.dart';
import 'package:calorie_tracker/src/dto/FoodItemEntry.dart';
import 'package:calorie_tracker/src/helpers/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n/app_localizations.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<FoodItemEntry> _allData = [];
  List<FoodItemEntry> _filteredData = [];
  List<CustomSymbolEntry> _userSymbols = [];
  bool _isLoading = true;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _loadData();

    // Listen to search input changes
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
        _filterData();
      });
    });
  }

  Future<void> _loadData() async {
    try {
      final List<FoodItemEntry> data = await DatabaseHelper.instance.getAllFoodItems(
          options: FoodItemSearchOptions(entryOrder: EntryOrder.DESC, columnFilterOption: ColumnFilterOption.ID));
      final List<CustomSymbolEntry> userSymbols = await DatabaseHelper.instance.getAllUserSymbols();
      setState(() {
        _allData = data;
        _filteredData = data;
        _isLoading = false;
        _userSymbols = userSymbols;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  void _filterData() {
    if (_searchQuery.isEmpty) {
      _filteredData = _allData;
    } else {
      _filteredData = _allData.where((item) {
        final String expression = item.calorieExpression;
        final String dateStr = _dateFormat.format(item.date);
        final String caloriesString =
            evaluateFoodItemWithCommentAndSymbols(expression, _userSymbols).toInt().toString();
        final String query = _searchQuery;

        return expression.contains(query) || dateStr.contains(query) || caloriesString.contains(query);
      }).toList();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchMenuHintText,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                            _filterData();
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
          ),

          // Results count and total calories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.searchMenuResultText(_filteredData.length),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Table
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredData.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _allData.isEmpty
                                  ? AppLocalizations.of(context)!.searchMenuNoItemsText1
                                  : AppLocalizations.of(context)!.searchMenuNoItemsFoundText1,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _allData.isEmpty
                                  ? AppLocalizations.of(context)!.searchMenuNoItemsText2
                                  : AppLocalizations.of(context)!.searchMenuNoItemsFoundText2,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[500],
                                  ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).disabledColor),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: DataTable(
                            columnSpacing: 15,
                            dataRowMinHeight: 48,
                            dataRowMaxHeight: 72,
                            headingRowColor: WidgetStateColor.resolveWith(
                              (states) => Theme.of(context).colorScheme.secondaryContainer,
                            ),
                            columns: [
                              DataColumn(
                                label: Text(
                                  AppLocalizations.of(context)!.searchMenuExpressionColumnLabel,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  AppLocalizations.of(context)!.searchMenuCaloriesColumnLabel,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  AppLocalizations.of(context)!.searchMenuDateColumnLabel,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: _filteredData.map((item) {
                              final int calories =
                                  evaluateFoodItemWithCommentAndSymbols(item.calorieExpression, _userSymbols).toInt();
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Container(
                                      constraints: const BoxConstraints(maxWidth: 150),
                                      child: _buildScrollableHighlightedText(
                                        item.calorieExpression.isEmpty ? '(empty)' : item.calorieExpression,
                                        _searchQuery,
                                        emptyStyle: item.calorieExpression.isEmpty,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      calories.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    _buildHighlightedText(
                                      _dateFormat.format(item.date),
                                      _searchQuery,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableHighlightedText(String text, String query, {TextStyle? style, bool emptyStyle = false}) {
    if (query.isEmpty) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectableText(
          text,
          style: emptyStyle
              ? TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ).merge(style)
              : style,
        ),
      );
    }

    final ScrollController scrollController = ScrollController();

    // Calculate the position of the first match to scroll to
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        final String lowerText = text.toLowerCase();
        final String lowerQuery = query.toLowerCase();
        final int matchIndex = lowerText.indexOf(lowerQuery);

        if (matchIndex != -1) {
          // Estimate character width (approximate)
          const double estimatedCharWidth = 8.0;
          final double highlightStartPosition = matchIndex * estimatedCharWidth;
          final double highlightWidth = query.length * estimatedCharWidth;

          // Get the viewport width (constrained to 150px as per the Container)
          const double viewportWidth = 150.0;

          // Calculate position to center the highlighted text
          final double highlightCenterPosition = highlightStartPosition + (highlightWidth / 2);
          final double targetPosition = highlightCenterPosition - (viewportWidth / 2);

          // Ensure we don't scroll beyond the bounds
          final double maxScrollExtent = scrollController.position.maxScrollExtent;
          final double clampedPosition = targetPosition.clamp(0.0, maxScrollExtent);

          // Only scroll if the highlight is not already visible
          final double currentScroll = scrollController.offset;
          final bool isHighlightVisible = highlightStartPosition >= currentScroll &&
              (highlightStartPosition + highlightWidth) <= (currentScroll + viewportWidth);

          if (!isHighlightVisible && clampedPosition != currentScroll) {
            scrollController.animateTo(
              clampedPosition,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        }
      }
    });

    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: SelectionArea(
        child: _buildHighlightedText(text, query, style: style, emptyStyle: emptyStyle),
      ),
    );
  }

  Widget _buildHighlightedText(String text, String query, {TextStyle? style, bool emptyStyle = false}) {
    if (query.isEmpty) {
      return Text(
        text,
        overflow: TextOverflow.visible,
        style: emptyStyle
            ? TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ).merge(style)
            : style,
      );
    }

    final List<TextSpan> spans = [];
    final String lowerText = text.toLowerCase();
    final String lowerQuery = query.toLowerCase();

    int start = 0;
    int index = lowerText.indexOf(lowerQuery, start);

    // Base style for non-highlighted text - use regular textTheme instead of primaryTextTheme
    final TextStyle baseStyle = emptyStyle
        ? TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ).merge(style)
        : TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color, // Changed from primaryTextTheme to textTheme
          ).merge(style);

    while (index != -1) {
      // Add text before the match
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: baseStyle,
        ));
      }

      // Add the highlighted match
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: TextStyle(
          backgroundColor: Colors.yellow[300],
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ).merge(style),
      ));

      start = index + query.length;
      index = lowerText.indexOf(lowerQuery, start);
    }

    // Add remaining text
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: baseStyle,
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
      overflow: TextOverflow.visible,
    );
  }
}
