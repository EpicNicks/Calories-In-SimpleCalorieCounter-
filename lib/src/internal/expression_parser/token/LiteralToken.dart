import 'Token.dart';

class LiteralToken implements Token {
  final double value;

  const LiteralToken(this.value);

  @override
  String toString() => value.toString();
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LiteralToken &&
          runtimeType == other.runtimeType &&
          value == other.value;
}
