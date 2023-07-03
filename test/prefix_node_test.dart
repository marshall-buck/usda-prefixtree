import 'package:test/test.dart';
import 'package:usda_db_creation/prefix_node.dart';

void main() {
  group('toJson', () {
    test('toJson should convert PTNode to a map', () {
      final node = PTNode(
        key: 'a',
        isEnd: true,
        left: PTNode(key: 'b'),
        middle: PTNode(key: 'c'),
        right: PTNode(key: 'd'),
      );

      final json = node.toJson();

      expect(json['key'], equals('a'));
      expect(json['isEnd'], equals(true));
      expect(json['left'], isA<Map>());
      expect(json['middle'], isA<Map>());
      expect(json['right'], isA<Map>());
    });
  });
  group('fromJson', () {
    test('fromJson should create PTNode from a map', () {
      final json = {
        'key': 'a',
        'isEnd': true,
        'left': {'key': 'b'},
        'middle': {'key': 'c'},
        'right': {'key': 'd'},
      };

      final node = PTNode.fromJson(json);

      expect(node.key, equals('a'));
      expect(node.isEnd, equals(true));
      expect(node.left, isA<PTNode>());
      expect(node.middle, isA<PTNode>());
      expect(node.right, isA<PTNode>());
    });
  });
  group('toString', () {
    test('toString should return a string representation of PTNode', () {
      final node = PTNode(
        key: 'a',
        left: PTNode(key: 'b'),
        middle: PTNode(key: 'c'),
        right: PTNode(key: 'd'),
      );

      final result = node.toString();

      expect(
          result,
          equals(
              'Node(key: a, left: Node(key: b, left: null, right: null, middle: null, isEnd: false), right: Node(key: d, left: null, right: null, middle: null, isEnd: false), middle: Node(key: c, left: null, right: null, middle: null, isEnd: false), isEnd: false)'));
    });
  });
}
