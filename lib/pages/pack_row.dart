import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/models/pack.dart';

class PackRow extends StatefulWidget {
  const PackRow(this.pack, {Key? key}) : super(key: key);
  final Pack pack;
  @override
  _PackRowState createState() => _PackRowState();
}

class _PackRowState extends State<PackRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.pack.authorName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Rating: " + widget.pack.rating.toString()),
                  Text(widget.pack.pointCount.toString() + " recordings"),
                ],
              ),
            ),
            Padding(
              child: Icon(Icons.download),
              padding: EdgeInsets.only(right: 15),
            ),
          ],
        ),
      ),
    );
  }
}
