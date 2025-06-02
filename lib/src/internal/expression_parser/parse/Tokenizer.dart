import '../token/InvalidToken.dart';
import '../token/LiteralToken.dart';
import '../token/OperatorToken.dart';
import '../token/Token.dart';

List<Token> tokenize(String input) {
  final List<Token> collectedTokens = [];
  const int numberCapture = 1;
  const int operatorCapture = 2;
  const int skipCapture = 3;
  const int mismatchCapture = 4;
  final RegExp tokenRegex = RegExp(r'(\d+(?:\.\d+)?)|'
      r'([+\-*x/^()])|'
      r'(\s+)|'
      r'(.)');

  for (final matchResult in tokenRegex.allMatches(input)) {
    if (matchResult.group(skipCapture) != null) {
      // Skip whitespace
    } else if (matchResult.group(numberCapture) != null) {
      final value = matchResult.group(numberCapture)!;
      if (collectedTokens.length > 0 && collectedTokens.last is LiteralToken) {
        collectedTokens.add(InvalidToken(matchResult.start, value));
      } else {
        collectedTokens.add(LiteralToken(double.parse(value)));
      }
    } else if (matchResult.group(operatorCapture) != null) {
      final operatorChar = matchResult.group(operatorCapture)![0];
      if ({'-', '+'}.contains(operatorChar) &&
          (collectedTokens.isEmpty ||
              (collectedTokens.last is OperatorToken &&
                  (collectedTokens.last as OperatorToken).operator != Operator.RPAREN))) {
        collectedTokens.add(OperatorToken.unaryFromChar(operatorChar));
      } else {
        OperatorToken operatorToken = OperatorToken.binaryFromChar(operatorChar);
        if (collectedTokens.isNotEmpty &&
            (collectedTokens.last is LiteralToken ||
                (collectedTokens.last is OperatorToken &&
                    (collectedTokens.last as OperatorToken) == OperatorToken.RPAREN)) &&
            operatorToken == OperatorToken.LPAREN) {
          collectedTokens.add(OperatorToken.MULTIPLY);
        }
        collectedTokens.add(operatorToken);
      }
    } else if (matchResult.group(mismatchCapture) != null) {
      final value = matchResult.group(mismatchCapture)!;
      collectedTokens.add(InvalidToken(matchResult.start, value));
    }
  }

  return collectedTokens;
}
