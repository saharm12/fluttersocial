import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/custom_widget/padding_with.dart';
import 'package:fluttersocial/custom_widget/post_content.dart';
import 'package:fluttersocial/custom_widget/profile_image.dart';
import 'package:fluttersocial/model/Member.dart';
import 'package:fluttersocial/model/alert_helper.dart';
import 'package:fluttersocial/model/post.dart';
import 'package:fluttersocial/util/constants.dart';
import 'package:fluttersocial/util/date_handler.dart';
import 'package:fluttersocial/util/firebase_handler.dart';

class PostTile extends StatelessWidget{
    late Post post;

  //DocumentSnapshot snapshot;
  Member? member;
    VoidCallback? onPressed;
  PostTile({ required this.post,  required this.member,required this.onPressed});

  @override
  Widget build(BuildContext context) {
      // late Post post ;

    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child:  Card(
        elevation: 5,
          child: Column(
            children: [
          
            PostContent(post: post, member: member, onPressed: onPressed),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      color: Colors.red,
                      icon: (post.likes!.contains(member?.uid) ? likeIcon : unlikeIcon ),
                    onPressed: () {
                        //c'est l'utlisateur qui va liker
                      FirebaseHandler().addOrRemoveLike(post, FirebaseHandler().authInstance.currentUser!.uid);
                    }),

                  Text("${post.likes?.length} likes"),
                  IconButton( icon: commentIcon,onPressed: (){
                   // color: Colors.red;
                    AlertHelper().writeAcomment(context, post: post, commentController: TextEditingController(), member: member);
                  },),
                  Text("${post.comments?.length} commentaires")


                ],
              )



            ],
          )
      ),
    );
  }
}