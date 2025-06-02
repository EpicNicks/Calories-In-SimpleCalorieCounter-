import 'package:calorie_tracker/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Markdown(
        data: AppLocalizations.of(context)!.faqMarkdown,
      ),
    ));
  }
}
