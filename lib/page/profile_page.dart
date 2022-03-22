import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/model/Member.dart';
import 'package:fluttersocial/model/color_theme.dart';
import 'package:fluttersocial/model/post.dart';
import 'package:fluttersocial/tile/post_tile.dart';
import 'package:fluttersocial/util/firebase_handler.dart';

class ProfilePage extends StatefulWidget{
   Member? member;
ProfilePage({@required this.member});

  @override
  State<StatefulWidget> createState() => ProfileState() ;

}
class ProfileState extends State<ProfilePage> {

   ScrollController? _controller;
  @override
  void initState() {
    _controller = ScrollController()..addListener(() {
      setState(() {

      });
    });
    super.initState();
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseHandler().postFrom(widget.member!.uid),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshots) {
          if (snapshots.hasData) {
            return CustomScrollView(
              controller: _controller,
              slivers: [
                  list(snapshots.data!.docs)
              ],
            );
          } else {
            return Center(
             // child: Text("Aucun post pour l'instant"),
            );
          }
        }
    );
  }


   SliverList list(List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
     return SliverList(
         delegate: SliverChildBuilderDelegate(
                 (BuildContext context, index) {
               if (index > snapshots.length) {
                 return null;
               } else if (index == snapshots.length){
                 return Text("Fin de liste");
               } else {
                 return PostTile(post: Post(snapshots[index]), member: widget.member, onPressed: () {  },);
               }
             }
         )
     );
   }





}
