import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TipsHowTo extends StatelessWidget {

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
            data: AppLocalizations.of(context)!.tipsMarkdown,
          ),
        )
    );
  }

}