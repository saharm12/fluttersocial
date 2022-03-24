import 'package:flutter/material.dart';
import 'package:fluttersocial/custom_widget/padding_with.dart';
import 'package:fluttersocial/custom_widget/profile_image.dart';
import 'package:fluttersocial/model/Member.dart';
import 'package:fluttersocial/model/post.dart';
import 'package:fluttersocial/util/constants.dart';
import 'package:fluttersocial/util/date_handler.dart';
import 'package:fluttersocial/util/firebase_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PostContent extends StatelessWidget {
  late Post post;

  //DocumentSnapshot snapshot;
  Member? member;
  VoidCallback? onPressed;
  PostContent({ required this.post,  required this.member,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // late Post post ;

    return Column(
      children: [
        Row(
          children: [
            ProfileImage(urlString: member?.imageUrl, onPressed: () {}),
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
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.85,
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.85,
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
            : Container(height: 0, width: 0,),





      ],
    );
  }
  }
