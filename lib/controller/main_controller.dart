import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttersocial/custom_widget/bar_item.dart';
import 'package:fluttersocial/model/Member.dart';
import 'package:fluttersocial/model/color_theme.dart';
import 'package:fluttersocial/page/chat.dart';
import 'package:fluttersocial/page/home_page.dart';
import 'package:fluttersocial/page/members_page.dart';
import 'package:fluttersocial/page/notifiaction_page.dart';
import 'package:fluttersocial/page/profile_page.dart';
import 'package:fluttersocial/page/write_post.dart';
import 'package:fluttersocial/util/constants.dart';
import 'package:fluttersocial/util/firebase_handler.dart';

import '../util/images.dart';
class MainController extends StatefulWidget {


  late String memberUid;
  MainController({required this.memberUid});

  @override
  State<StatefulWidget> createState() =>MainState();

}
 class MainState extends State<MainController> {
 GlobalKey<ScaffoldState>_globalKey = GlobalKey<ScaffoldState>();
  late StreamSubscription streamSubscription;
  Member? member;
  late  int index = 0 ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamSubscription = FirebaseHandler().fire_user.doc(widget.memberUid).snapshots().listen((event) {
       setState(() {
         member  = Member(event);
       });
    });
    //Récupere user a partiire de uid
  }
  @override
  void dispose() {
 streamSubscription.cancel();
  super.dispose();
  }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       key: _globalKey,
      // appBar: AppBar(title: Text("salut"),),
       body: showPage(),
       bottomNavigationBar: BottomAppBar(
         color: ColorTheme().accent(),
         shape: CircularNotchedRectangle(),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           mainAxisSize: MainAxisSize.max,
           children: [
             BarItem(icon: homeIcon, onPressed: (() => buttonSelected(0)), selected: (index == 0)),
             BarItem(icon: friendsIcon, onPressed: (() => buttonSelected(1)), selected: (index == 1)),
             Container(width: 70, height: 0,),
             BarItem(icon: notifIcon, onPressed: (() => buttonSelected(2)), selected: (index == 2)),
             BarItem(icon: profileIcon, onPressed: (() => buttonSelected(3)), selected: (index == 3)),
             BarItem(icon: commentIcon, onPressed:(() => buttonSelected(4)), selected:  (index == 4))
           ],
         ),
       ),

     /**floatingActionButton: SpeedDial(
       animatedIcon: AnimatedIcons.list_view,
     children: [
       SpeedDialChild(

        child: Icon(Icons.event),
        label: "First Item",
         onTap: () => print("first!")
     ),

       SpeedDialChild(
           child: writePost,
           backgroundColor: Colors.yellow,
           label: "First Item",
           onTap: () => print("second!"),

       ),
     ],**/

         floatingActionButton:
           SpeedDial(
           onPress: () {
           _globalKey.currentState!.showBottomSheet((context) => WritePost(memberId: widget.memberUid,));
           },
           child: writePost,
           ),


           floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,



     );










   }


  buttonSelected(int index){
    setState(() {
      this.index = index;
    });
  }
  Widget? showPage() {
    switch (index) {
      case 0: return HomePage(member: member);
      case 1: return MembersPage(member: member);
      case 2: return NotifPage(member: member);
      case 3: return ProfilePage(member: member);
      case 4: return ChatPage();
    }
  }
 }