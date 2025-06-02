import 'Token.dart';

class InvalidToken implements Token {
  final int position;
  final String invalidShard;

  const InvalidToken(this.position, this.invalidShard);

  @override
  String toString() =>
      'InvalidToken(position: $position, shard: "$invalidShard")';
}
