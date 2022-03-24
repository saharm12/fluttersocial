import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/custom_widget/padding_with.dart';
import 'package:fluttersocial/custom_widget/profile_image.dart';
import 'package:fluttersocial/model/Member.dart';
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
              Row(
                 children: [
                   ProfileImage(urlString: member?.imageUrl, onPressed : (){}),
                   Column(
                     children: [
                       Text("${member?.surname} ${member?.name}"),
                     Text(DateHandler().myDate(post.date!))
                     ],

                   )
                 ],
              ),
              Divider(),
                (post.imageUrl != "null" && post.imageUrl != "")
                     ? PaddingWith(
                    child: Container (
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                         image: CachedNetworkImageProvider(post.imageUrl!),
                            fit: BoxFit.cover,

                        )
                      ),
                    )
                )
                    : Container(height: 0, width: 0,),
              (post.text != null && post.text != "")
                  ? Text(post.text!)
                  :  Container(height: 0, width: 0,),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      color: Colors.red,
                      icon: (post.likes!.contains(member?.uid) ? likeIcon : unlikeIcon ),
                    onPressed: () {
                      FirebaseHandler().addOrRemoveLike(post, member!.uid);
                    }),

                  Text("${post.likes?.length} likes"),
                  IconButton(onPressed: null, icon: commentIcon),
                  Text("${post.comments?.length} commentaires")

                ],
              )



            ],
          )
      ),
    );
  }
}