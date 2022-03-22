import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/custom_widget/my_gradient.dart';
import 'package:fluttersocial/custom_widget/my_textField.dart';
import 'package:fluttersocial/custom_widget/padding_with.dart';
import 'package:fluttersocial/model/color_theme.dart';
import 'package:fluttersocial/util/constants.dart';
import 'package:fluttersocial/util/firebase_handler.dart';
import 'package:image_picker/image_picker.dart';

class WritePost extends StatefulWidget {
  late String memberId;
  WritePost({required this.memberId});
  @override
  State<StatefulWidget> createState() => WriteState() ;

}

class WriteState extends State<WritePost> {
  late TextEditingController _controller;
   File? _imageFile;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return Container(
    color: ColorTheme().base(),
    height: MediaQuery.of(context).size.height * 0.8,
    width: MediaQuery.of(context).size.width,
    child: PaddingWith(
      bottom: 0,
      child:
      Container(
        decoration: BoxDecoration(
            color: ColorTheme().base(),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
        ),
        child: InkWell(
            onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
            child: SingleChildScrollView (
              child:  Column(
                children: [
                  PaddingWith(child: Text("Nouvelle post..."),),
                  PaddingWith(child: MyTextField(controller: _controller, hint: "Exprimez vous" , icon: writePost,)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (() => takePicture(ImageSource.camera)), icon: cameraIcon),
                      IconButton(onPressed: (() => takePicture(ImageSource.gallery)), icon: libraryIcon),
                    ],
                  ),
                  Container(

                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: (_imageFile == null) ? Text("Aucune image") : Image.file(_imageFile!)

                  ),
                  Card(
                    elevation: 7.5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: MyGradient(
                        //couleur du button
                        startColor: ColorTheme().accent(),
                        endColor: ColorTheme().pointer(),
                      radius: 25,
                      horizontal: true
                      ),
                      child: TextButton(
                        child: Text("Envoyer"),
                        onPressed: () {
                          //envoyer à Firebase
                          sendToFirebase();
                        },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          )
                      ),
                    ),
                  )
                ],
              )
            )


        ),
      ),
    )





  );
  }
  takePicture(ImageSource source) async {
    print('entry here?');

    final imagePath = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);
    print("et ici ? ");

     final file = File(imagePath!.path);
    setState(() {
      _imageFile = file;
    });
  }


  sendToFirebase(){
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context);
    //soit une image soit un text
    if ((_imageFile != null) || (_controller.text != null && _controller.text != "")){
        FirebaseHandler().addPosttoFirebase(widget.memberId, _controller.text, _imageFile!);
    }
  }


}