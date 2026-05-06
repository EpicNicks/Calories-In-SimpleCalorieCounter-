import 'package:flutter/material.dart';

import '../dto/CustomSymbolEntry.dart';

class SymbolBoldingTextEditingController extends TextEditingController {
  final List<CustomSymbolEntry> userSymbols;

  SymbolBoldingTextEditingController({required this.userSymbols});

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final text = this.text;
    if (userSymbols.isEmpty) return TextSpan(text: text, style: style);

    final pattern = userSymbols.map((s) => RegExp.escape(s.name)).join('|');
    final regex = RegExp(pattern);

    final spans = <TextSpan>[];
    int last = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > last) {
        spans.add(TextSpan(text: text.substring(last, match.start), style: style));
      }
      spans.add(TextSpan(
        text: match.group(0),
        style: style?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle(fontWeight: FontWeight.bold),
      ));
      last = match.end;
    }

    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last), style: style));
    }

    return TextSpan(children: spans, style: style);
  }
}
