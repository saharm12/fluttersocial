
import 'package:flutter/cupertino.dart';
import 'package:fluttersocial/model/Member.dart';

class NotifPage extends StatefulWidget{
  Member? member;
  NotifPage ({@required this.member});

  @override
  State<StatefulWidget> createState() => NotifState() ;

}
class NotifState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Notification page"),
    );
  }
}