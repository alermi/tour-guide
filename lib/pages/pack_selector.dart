import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tour_guide/models/pack.dart';
import 'package:tour_guide/models/tour_site.dart';
import 'package:tour_guide/pages/error.dart';
import 'package:tour_guide/pages/get_pack.dart';
import 'package:tour_guide/pages/map.dart';
import 'package:tour_guide/services/database.dart';

import 'loading.dart';

class PackSelector extends StatefulWidget {
  const PackSelector(this.tourSite, {Key? key}) : super(key: key);
  final TourSite tourSite;
  @override
  _PackSelectorState createState() => _PackSelectorState(tourSite);
}

class _PackSelectorState extends State<PackSelector> {
  _PackSelectorState(TourSite tourSite)
      : _packs = DatabaseService.instance
            .getPurchasedTourSitePacks(tourSite.uniqueId) {
    print('initializing _packs');
  }
  int selectedIndex = 0;
  Future<List<Pack>> _packs;

  @override
  Widget build(BuildContext context) {
    print('building');
    return FutureBuilder<List<Pack>>(
      future: _packs,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
              home: ErrorPage(message: snapshot.error.toString()));
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(home: LoadingPage());
        }
        if (!snapshot.hasData || snapshot.data == null) {
          //TODO: Handle
          print(snapshot.data);
          return Text("Not handled state: hasData false");
        }
        if (snapshot.data!.isEmpty) {
          return GetPackView(
            widget.tourSite,
            () {
              setState(() {
                _packs = DatabaseService.instance
                    .getPurchasedTourSitePacks(widget.tourSite.uniqueId);
              });
              return _packs;
            },
          );
        } else {
          List<Widget> list =
              snapshot.data!.map((e) => Text(e.tourGuide.name)).toList();
          return Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: ListWheelScrollView(
                  children: list,
                  itemExtent: 42,
                  useMagnifier: true,
                  magnification: 1.5,
                  onSelectedItemChanged: (int i) {
                    print('Selected index ' + i.toString());
                    setState(() {
                      selectedIndex = i;
                    });
                  },
                ),
              ),
              Flexible(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  // MapPage(snapshot.data![selectedIndex])),
                                  MapPage(widget.tourSite,
                                      snapshot.data![selectedIndex])),
                        );
                      },
                      child: Text('Start')))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          );
        }
      },
    );
  }
}
