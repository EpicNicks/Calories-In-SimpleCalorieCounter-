import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Faq extends StatelessWidget {

  final _mdString =
"""
# FAQ
---
## Usable Math Symbols for entries
- +, -, x and *, / for mathematical operations
- , (comma) to separate items within an entry  
  \(this is semantically equivalent to addition\)

---

## Optional Notes on Entries
You may label additional information, such as the name of the food logged or whatever else you would like in a comment
by adding a : (colon) to your entry and adding your comment after, such as\\
**100+80+50: egg and toast w/ jam**

---

""";

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
            data: _mdString,
          ),
        )
    );
  }
}