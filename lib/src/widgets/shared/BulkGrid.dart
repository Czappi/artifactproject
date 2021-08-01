import 'package:flutter/material.dart';

class BulkGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  const BulkGrid({
    Key? key,
    required this.crossAxisCount,
    required this.children,
  })  : assert(crossAxisCount > 1),
        assert(children.length >= crossAxisCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var rowChildren = divideChildren(children, crossAxisCount);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(crossAxisCount, (index) {
          return Row(
            children: rowChildren[index],
          );
        }),
      ),
    );
  }

  List<List<Widget>> divideChildren(List<Widget> children, int crossAxisCount) {
    int dividedLength = children.length ~/ crossAxisCount;

    List<Widget> _children = children;
    List<List<Widget>> result = [];

    for (var i = 1; i <= crossAxisCount; i++) {
      result.add(_children.sublist(
          0, (i != crossAxisCount) ? dividedLength : _children.length));
      _children.removeRange(0, dividedLength);
    }

    return result;
  }
}
