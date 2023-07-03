/// Class representing a [PrefixTree] node.
///
/// Properties:
///
/// [left], [right], [middle] -  are pointers to the next node.
/// [key] is the character the node represents.
/// [isEnd] will be true if it represents the end of a word.

class PTNode {
  String? key;
  bool? isEnd;
  PTNode? left;
  PTNode? middle;
  PTNode? right;

  PTNode({this.key, this.left, this.right, this.middle, this.isEnd = false});

  // Convert node to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'isEnd': isEnd,
      'left': left?.toJson(),
      'middle': middle?.toJson(),
      'right': right?.toJson(),
    };
  }

  // Create PTNode from a JSON representation.
  factory PTNode.fromJson(Map<String, dynamic> json) {
    return PTNode(
      key: json['key'],
      isEnd: json['isEnd'],
      left: json['left'] != null ? PTNode.fromJson(json['left']) : null,
      middle: json['middle'] != null ? PTNode.fromJson(json['middle']) : null,
      right: json['right'] != null ? PTNode.fromJson(json['right']) : null,
    );
  }

  @override
  String toString() {
    return 'Node(key: $key, left: $left, right: $right, middle: $middle, isEnd: $isEnd)';
  }
}
