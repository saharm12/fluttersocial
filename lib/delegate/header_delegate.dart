import 'package:flutter/material.dart';
import 'package:fluttersocial/model/Member.dart';
import 'package:fluttersocial/model/color_theme.dart';
import 'package:fluttersocial/util/firebase_handler.dart';

class HeaderDeleagate extends SliverPersistentHeaderDelegate  {
   Member member;
   VoidCallback? callback;
   bool scrolled;

  HeaderDeleagate({
    required this.member,
    required this.scrolled,
    required this.callback

});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
   return Container(
     margin: EdgeInsets.only(bottom: 5),
     padding: EdgeInsets.all(10) ,
     color: ColorTheme().accent(),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       mainAxisSize: MainAxisSize.max,
       children: [
         (scrolled) //si on a deroulé
             ? Container(height: 0, width: 0,)
             : InkWell (

           child: Text("${member.surname} ${member.name}"),

           onTap:
            // print("on tap");
             callback


         ),
         Text(member.description ?? "Aucune description"),
         Divider(),
         Row(
           mainAxisSize:  MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
              TextButton(onPressed: null, child: Text("Abonnés: ${member.followers.length}")),
              TextButton(onPressed: null, child: Text("Abonnements: ${member.following.length}"))


           ],
         )
       ],
     )
   );
  }




  @override
  // TODO: implement maxExtent
  double get maxExtent => (scrolled ? 125: 200);
  @override
  // TODO: implement minExtent
  double get minExtent => (scrolled) ? 125 : 200;
 //si membre a changé
  @override
  bool shouldRebuild(HeaderDeleagate oldDelegate) => scrolled!= oldDelegate.scrolled || member != oldDelegate.member;


}