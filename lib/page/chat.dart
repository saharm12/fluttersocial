import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttersocial/model/Member.dart';
import 'package:fluttersocial/model/chatUsersModel.dart';
import 'package:fluttersocial/page/members_page.dart';
import 'package:fluttersocial/page/profile_page.dart';

class ChatPage extends StatefulWidget {
  Member? member;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override

  Widget build(BuildContext context) {
    List<MembersPage> Member = [


    ];

    return Scaffold(

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Chat", style: TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add, color: Colors.pink, size: 20,),
                          SizedBox(width: 2,),
                          Text("Add New", style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),),


                        ],
                      ),
                    )
                  ],
                ),
              ),

            ),
            Padding(

              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),

          ],

        ),

      ),
      floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.list_view,
          children: [
          SpeedDialChild(

          child: Icon(Icons.email),
              backgroundColor: Colors.red,

              label: "Gmail",
          onTap: () => print("first!")
          ),

            SpeedDialChild(

                backgroundColor: Colors.indigo,
                child: Icon(Icons.facebook),
                label: "Facebook",
                onTap: () => print("first!")
            ),
            SpeedDialChild(

                child: Icon(Icons.contact_page),
                backgroundColor: Colors.white,

                label: "Contact",
                onTap: () => print("Contact!")
            ),



          ],



    )
    );




  }

}