import 'package:flutter/material.dart';

class SmartHorizontalListView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsets padding;
  final Function onListEndReached;
  const SmartHorizontalListView({Key? key, 
  required this.itemCount,
    required this.padding,
    required this.itemBuilder,
    required this.onListEndReached
}) : super(key: key);

  @override
  State<SmartHorizontalListView> createState() => _SmartHorizontalListViewState();
}

class _SmartHorizontalListViewState extends State<SmartHorizontalListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.atEdge) {
        if(_scrollController.position.pixels == 0) {
          print("Start of the List Page Reached");
        }else {
          print("End of the List Page Reached");
          widget.onListEndReached();
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: widget.padding,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
      ),
    );
  }
}
