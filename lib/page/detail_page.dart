import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/model/Member.dart';
import 'package:fluttersocial/model/member_comment.dart';
import 'package:fluttersocial/model/post.dart';
import 'package:fluttersocial/tile/comment_tile.dart';
import 'package:fluttersocial/tile/post_tile.dart';
import 'package:fluttersocial/util/constants.dart';
//import 'package:fluttersocial/util/constants.dart';

class DetailPage extends StatefulWidget{
   late Post post;
  Member? member;

  DetailPage({ required this.post, required member});
  @override
  State<StatefulWidget> createState() => DetailState();
}
class DetailState extends State<DetailPage> {
   @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text("detail du post")),
       body: StreamBuilder<DocumentSnapshot>(
         stream: widget.post.ref.snapshots(),
         builder:  (BuildContext context, AsyncSnapshot<DocumentSnapshot> snaps){
           //return Text(snaps.data!.data().toString());
            List<MemberComment> comments = [];
            final   datas = snaps.data!;
            final commentsSnap = datas[commentKey];
            commentsSnap.forEach((s) {
              comments.add(MemberComment(s));
            });
            print(comments.length);
            return ListView.separated(
                itemBuilder: (context, index)  {
                  if(index == 0){
                    return PostTile(post: widget.post, member: widget.member, onPressed: (){},);
                  } else {
                    MemberComment comment = comments[index - 1];
                    //return ListTile(title: Text(comment.text!));
                     return CommentTile(memberComment: comment,);
                  }
                },
                separatorBuilder: (context, index ) {
                 return Divider();
                },
                itemCount: comments.length + 1
            );
            },

       )
   );
  }
}