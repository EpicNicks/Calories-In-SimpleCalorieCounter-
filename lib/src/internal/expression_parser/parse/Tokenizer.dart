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

  String invalidBuffer = '';
  int invalidStartPosition = -1;

  void flushInvalidBuffer() {
    if (invalidBuffer.isNotEmpty) {
      collectedTokens.add(InvalidToken(invalidStartPosition, invalidBuffer));
      invalidBuffer = '';
      invalidStartPosition = -1;
    }
  }

  for (final matchResult in tokenRegex.allMatches(input)) {
    if (matchResult.group(skipCapture) != null) {
      // Whitespace ends any invalid token collection
      flushInvalidBuffer();
      // Skip whitespace
    } else if (matchResult.group(numberCapture) != null) {
      // Valid number found, flush any accumulated invalid tokens
      flushInvalidBuffer();

      final value = matchResult.group(numberCapture)!;
      if (collectedTokens.length > 0 &&
          (collectedTokens.last is LiteralToken || collectedTokens.last == OperatorToken.RPAREN)) {
        // This number following another number is invalid
        invalidStartPosition = matchResult.start;
        invalidBuffer = value;
      } else {
        collectedTokens.add(LiteralToken(double.parse(value)));
      }
    } else if (matchResult.group(operatorCapture) != null) {
      // Valid operator found, flush any accumulated invalid tokens
      flushInvalidBuffer();

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
      // Invalid character found, add to buffer
      final value = matchResult.group(mismatchCapture)!;
      if (invalidBuffer.isEmpty) {
        invalidStartPosition = matchResult.start;
      }
      invalidBuffer += value;
    }
  }

  // Flush any remaining invalid tokens at the end
  flushInvalidBuffer();

  return collectedTokens;
}
