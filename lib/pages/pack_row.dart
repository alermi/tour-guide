import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/models/pack.dart';
import 'package:tour_guide/services/database.dart';

class PackRow extends StatefulWidget {
  const PackRow(this.pack, this.reloadPacks, {Key? key}) : super(key: key);
  final Pack pack;
  final Future<void> Function() reloadPacks;

  @override
  _PackRowState createState() => _PackRowState();
}

class _PackRowState extends State<PackRow> {
  bool downloading = false;

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
                    widget.pack.tourGuide.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Tour Rating: " +
                      (widget.pack.rating != null
                          ? widget.pack.rating.toString() +
                              " (" +
                              widget.pack.numRatings.toString() +
                              " ratings)"
                          : "--")),
                  Text("Author Rating: " +
                      (widget.pack.tourGuide.rating != null
                          ? widget.pack.tourGuide.rating.toString()
                          : "--")),
                  Text(widget.pack.pointCount.toString() + " recordings"),
                ],
              ),
            ),
            InkWell(
              child: Padding(
                child: downloading
                    ? CircularProgressIndicator()
                    : Icon(Icons.download),
                padding: EdgeInsets.only(right: 15),
              ),
              onTap: () {
                setState(() {
                  downloading = true;
                });
                Future<void> downloadFuture = DatabaseService.instance
                    .purchasePack(
                        widget.pack.tourSiteUniqueId, widget.pack.uniqueId);
                downloadFuture.whenComplete(() {
                  setState(() {
                    downloading = false;
                  });
                  widget.reloadPacks();
                });
                downloadFuture.onError((error, stackTrace) {
                  setState(() {
                    downloading = false;
                  });
                  //TODO: Handle download error
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
