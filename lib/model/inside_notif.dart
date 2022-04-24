import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttersocial/util/constants.dart';
import 'package:fluttersocial/util/date_handler.dart';

class InsideNotif {
   DocumentReference? reference;
   String? text;
   String? date;
   String? userId;
   late DocumentReference<Map<String, dynamic>> aboutRef;
   bool? seen;
   String? type;

  InsideNotif(DocumentSnapshot<Map<String, dynamic>> snap) {
    reference = snap.reference;
    Map<String, dynamic> map = snap.data()!;
    text = map[textKey];
    date = DateHandler().myDate(map[dateKey]);
    userId = map[uidKey];
    aboutRef = map[refKey];
    seen = map[seenKey];
    type = map[typeKey];
  }
}

enum NotifType {
  lik, follow, comment
}
