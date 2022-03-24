import '../util/constants.dart';
import '../util/date_handler.dart';

class MemberComment {

  String? memberId;
  String? text;
  String? date;

  MemberComment(Map<String, dynamic> map) {
    memberId = map[uidKey];
    text = map[textKey];
    date = DateHandler().myDate(map[dateKey]);


  }
}