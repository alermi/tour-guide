import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tour_guide/models/tour_site.dart';
import 'package:tour_guide/pages/error.dart';
import 'package:tour_guide/pages/map.dart';
import 'package:tour_guide/services/database.dart';

import 'loading.dart';

class SiteSelector extends StatefulWidget {
  const SiteSelector({Key? key}) : super(key: key);

  @override
  _SiteSelectorState createState() => _SiteSelectorState();
}

class _SiteSelectorState extends State<SiteSelector> {
  int selectedIndex = 0;
  Future<List<TourSite>> _tourSites = DatabaseService.instance.getTourSites();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TourSite>>(
      future: _tourSites,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
              home: ErrorPage(message: snapshot.error.toString()));
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(home: LoadingPage());
        }
        if (!snapshot.hasData) {
          //TODO: Handle
          return Text("Not handled state: hasData false");
        } else {
          List<Widget> list =
              snapshot.data!.map((e) => Text(e.siteName)).toList();
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
                          MaterialPageRoute(builder: (context) => MapPage()),
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
