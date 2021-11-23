import 'package:tour_guide/models/tour_guide.dart';

class Pack {
  String uniqueId;
  TourGuide tourGuide;
  double? rating;
  int numRatings;
  int pointCount;
  String tourSiteUniqueId;
  Pack(this.uniqueId, this.tourGuide, this.rating, this.numRatings,
      this.pointCount, this.tourSiteUniqueId);
}
