import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide/models/app_user.dart';
import 'package:tour_guide/models/pack.dart';
import 'package:tour_guide/pages/error.dart';
import 'package:tour_guide/pages/loading.dart';
import 'package:tour_guide/services/database.dart';

class ReviewDialog extends StatefulWidget {
  const ReviewDialog(this.pack, {Key? key}) : super(key: key);
  final Pack pack;
  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double? initialRating;
  double? currRating;
  Future<double?>? getUserReviewFuture;
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<AppUser?>(context);
    if (getUserReviewFuture == null) {
      Future<double?> tempFuture = DatabaseService.instance
          .getUserReview(_user!.uid, widget.pack.uniqueId);
      tempFuture.then((value) {
        setState(() {
          initialRating = value;
          currRating = value ?? 5;
        });
      });
      setState(() {
        getUserReviewFuture = tempFuture;
      });
    }
    return FutureBuilder(
        future: getUserReviewFuture,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return MaterialApp(
                home: ErrorPage(message: snapshot.error.toString()));
          }
          // Once complete, show your application
          if (snapshot.connectionState != ConnectionState.done) {
            return LoadingPage();
          } else {
            return AlertDialog(
              title: initialRating == null
                  ? Text("Add Review")
                  : Text('Update Review'),
              content: RatingBar.builder(
                initialRating: initialRating ?? 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  currRating = rating;
                },
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                TextButton(
                  onPressed: () {
                    DatabaseService.instance.leaveReview(
                        _user!.uid, widget.pack.uniqueId, currRating!);
                    Navigator.pop(context);
                  },
                  child: Text('Done'),
                )
              ],
            );
          }
        });
  }
}
