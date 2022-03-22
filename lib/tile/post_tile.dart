import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/custom_widget/profile_image.dart';
import 'package:fluttersocial/model/Member.dart';
import 'package:fluttersocial/model/post.dart';
import 'package:fluttersocial/util/date_handler.dart';

class PostTile extends StatelessWidget{
  Post post;

  //DocumentSnapshot snapshot;
  Member? member;
    VoidCallback? onPressed;
  PostTile({required this.post, required this.member,required this.onPressed});

  @override
  Widget build(BuildContext context) {
      //Post post = Post(snapshot);

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
                       Text(DateHandler().myDate(post.date))
                     ],
                   )
                 ],
              )
            ],
          )
      ),
    );
  }
}