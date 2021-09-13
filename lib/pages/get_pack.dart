import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/models/pack.dart';
import 'package:tour_guide/models/tour_site.dart';
import 'package:tour_guide/pages/error.dart';
import 'package:tour_guide/pages/loading.dart';
import 'package:tour_guide/pages/pack_row.dart';
import 'package:tour_guide/services/database.dart';

class GetPackView extends StatefulWidget {
  const GetPackView(this.tourSite, {Key? key}) : super(key: key);
  final TourSite tourSite;
  @override
  _GetPackViewState createState() => _GetPackViewState(tourSite);
}

class _GetPackViewState extends State<GetPackView> {
  _GetPackViewState(this.tourSite)
      : getPacks =
            DatabaseService.instance.getAvailablePacks(tourSite.uniqueId);
  final TourSite tourSite;
  Future<List<Pack>> getPacks;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: getPacks,
      builder: (context, AsyncSnapshot<List<Pack>> snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
              home: ErrorPage(message: snapshot.error.toString()));
        }
        // Once complete, show your application
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(home: LoadingPage());
        } else {
          return Column(
            children: [
              Padding(
                child: Text(
                    'You do not have any packs available in this tour site. Please get some!'),
                padding: EdgeInsets.all(30),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  child: ListView(
                    children: snapshot.data!
                        .map<Widget>((element) => PackRow(element))
                        .toList(),
                  )),
            ],
          );
        }
      },
    );
  }
}
