 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/custom_widget/my_textField.dart';
import 'package:fluttersocial/custom_widget/post_content.dart';
import 'package:fluttersocial/model/Member.dart';
import 'package:fluttersocial/model/post.dart';
import 'package:fluttersocial/util/constants.dart';
import 'package:fluttersocial/util/firebase_handler.dart';

 class AlertHelper {

   Future<void> error(BuildContext context, String error) async {
     bool isiOS = (Theme.of(context).platform == TargetPlatform.iOS);
     final title = Text("Erreur");
     final explanation = Text(error);
     return showDialog(
         context: context,
         builder: (BuildContext ctx) {
           return (isiOS)
               ? CupertinoAlertDialog(title: title, content: explanation, actions: [close(ctx, "OK")],)
               : AlertDialog(title: title, content: explanation, actions: [close(ctx, "OK")],);
         }
     );
   }
   //deconx
   Future<void>? disconnect(BuildContext context) async{
     bool isiOS = (Theme.of(context).platform == TargetPlatform.iOS);

     Text title = Text("Voulez vous vraiment déconnecter?");
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext ctx) {
           return (isiOS)
               ? CupertinoAlertDialog(title: title, actions: [close(context, "Non"), disconnectBtn(context)])
               : AlertDialog(title: title, actions: [close(context, "Non"), disconnectBtn(context)], );
          });
   }
   Future<void> writeAcomment(BuildContext context, {required Post post, required TextEditingController commentController, required member}) async{
     MyTextField commentTextField = MyTextField(controller: commentController , hint: "Ecrivez un commentaire");
     Text title = Text(" Nouveau commentaires");
     return  showDialog(context: context, builder: (BuildContext ctx) {
       return AlertDialog(
             title: title,
             content: SingleChildScrollView (
               child:   Column (
                 children: [
                   PostContent(post: post,  member: member, onPressed: (){}),
                   commentTextField
                 ],
               ),
             ),
          actions: [
            close(context, "Annuler"),
            TextButton(
                onPressed: (){
                  if (commentController.text != null && commentController.text != ""){
                     FirebaseHandler().addComent(post, commentController.text);
                     Navigator.pop(context);
                  }
                },
                child: Text("Valider"))
          ],
       );
     });
   }


   //alert pour description change user desc alert
   Future<void> changeUser(
       BuildContext context  ,{
         required Member member,
         required TextEditingController name,
         required TextEditingController surname,
         required TextEditingController desc
           }
       ) async {

     MyTextField nameTF=   MyTextField(controller: name, hint: member.name,);
     MyTextField surnameTF= MyTextField(controller: surname, hint: member.surname,);
     MyTextField descTF= MyTextField(controller: desc, hint:member.description ?? "Aucune description" );
        Text text =  Text("Modification des donnees");
         return showDialog(
             context: context,
             builder: (BuildContext ctx) {
                return AlertDialog(
                  title: text ,
                  backgroundColor: Colors.white70,
                  content: Column(

                    children: [nameTF,surnameTF,descTF],
                  ),
                  actions: [
                    close((context), "Annuler"),
                  TextButton(
               child: Text("valider"),
                    onPressed: () {
                     Map<String, dynamic> datas = {};
                     if(name.text != null && name.text != ""){
                       datas[nameKey] = name.text;
                     }
                     if(surname.text != null && surname.text !="") {
                       datas[surnameKey] = surname.text;
                     }
               if(desc.text != null && desc.text !="") {
                 datas[descriptionKey] = desc.text;

               }
               //modifier
               FirebaseHandler().modifyMember(datas, member.uid);
               //si modifier en ferme la fenetre
                     Navigator.pop(context);

               },
               )
                  ]
                );
      });
   }
   //alert pour deconx
   TextButton disconnectBtn(BuildContext context){
     return TextButton(
       //logout
         onPressed: (){
           Navigator.pop(context);
           FirebaseHandler().logOut();
         },
         child: Text("Oui"));
   }


   
  TextButton close(BuildContext context, String string){
    return TextButton(
        onPressed:(() => Navigator.pop(context)), child: Text(string)
    );
  }



 }