import 'Token.dart';

class OperatorToken implements Token {
  final Operator operator;
  final Associativity associativity;
  final int numOperands;
  final int precedence;

  const OperatorToken._(
      this.operator, this.associativity, this.numOperands, this.precedence);

  @override
  String toString() => operator.name;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperatorToken &&
          runtimeType == other.runtimeType &&
          operator == other.operator &&
          associativity == other.associativity &&
          numOperands == other.numOperands &&
          precedence == other.precedence;

  static const PLUS =
      OperatorToken._(Operator.PLUS, Associativity.LEFT, 2, 1);
  static const MINUS =
      OperatorToken._(Operator.MINUS, Associativity.LEFT, 2, 1);
  static const MULTIPLY =
      OperatorToken._(Operator.MULTIPLY, Associativity.LEFT, 2, 2);
  static const DIVIDE =
      OperatorToken._(Operator.DIVIDE, Associativity.LEFT, 2, 2);
  static const EXPONENT =
      OperatorToken._(Operator.EXPONENT, Associativity.RIGHT, 2, 3);
  static const UNARY_PLUS =
      OperatorToken._(Operator.UNARY_PLUS, Associativity.RIGHT, 1, 4);
  static const UNARY_MINUS =
      OperatorToken._(Operator.UNARY_MINUS, Associativity.RIGHT, 1, 4);
  static const LPAREN =
      OperatorToken._(Operator.LPAREN, Associativity.NONE, 0, 5);
  static const RPAREN =
      OperatorToken._(Operator.RPAREN, Associativity.NONE, 0, 5);

  static OperatorToken unaryFromChar(String operatorChar) =>
      switch (operatorChar) {
        '+' => UNARY_PLUS,
        '-' => UNARY_MINUS,
        _ => throw ArgumentError('Invalid unary operator: $operatorChar'),
      };
  static OperatorToken binaryFromChar(String operatorChar) =>
      switch (operatorChar) {
        '+' => PLUS,
        '-' => MINUS,
        '*' || 'x' => MULTIPLY,
        '/' || '÷' => DIVIDE,
        '^' => EXPONENT,
        '(' => LPAREN,
        ')' => RPAREN,
        _ => throw ArgumentError('Invalid binary operator: $operatorChar'),
      };
}

enum Operator {
  PLUS,
  MINUS,
  MULTIPLY,
  DIVIDE,
  EXPONENT,
  UNARY_PLUS,
  UNARY_MINUS,
  LPAREN,
  RPAREN
}

enum Associativity { LEFT, RIGHT, NONE }
