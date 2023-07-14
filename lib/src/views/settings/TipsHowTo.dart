import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TipsHowTo extends StatelessWidget {
  final _mdString =
"""
# Tips and How Tos
---
## How to Calculate Partial Servings
Partial Servings can be entered as:

calories-per-serving x amount / amount-per-serving

So if you had cereal that was measured in 60 gram servings, you ate 90 grams of it, and the
amount of calories per serving is 200, The total calories can be entered as:\\
**200 x 90 / 60** ***(=300)***

---
""";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange.shade500,
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.orange.shade500,
          ),
          body: Markdown(
            data: _mdString,
          ),
        )
    );
  }

}