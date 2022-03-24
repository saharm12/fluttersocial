import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttersocial/util/constants.dart';

class Post {
   late DocumentReference<Map<String, dynamic>> ref;
   String? documentId ="";
    String? id= "";
    String? memberId ="";
   String? text ="";
    String? imageUrl ;
    int? date ;
  List<dynamic>? likes;
   List<dynamic>? comments;

  Post(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    ref = snapshot.reference;
    documentId = snapshot.id;
    Map<String, dynamic>? datas = snapshot.data();
    memberId = datas?[uidKey];
    id = datas?[postIdKey] ;
    text = datas?[textKey];
    imageUrl = datas?[imageUrlKey];
    date = datas?[dateKey];
    likes = datas?[likeKey];
    comments = datas?[commentKey];
  }

  Map<String, dynamic>toMap() {
    Map<String, dynamic> map = {
      postIdKey: id,
      //postIdKey: id,
      uidKey: memberId,
      likeKey: likes,
      commentKey: comments
    };

    if (text != null) {
      map[textKey] = text;
    }
    if (imageUrl != null) {
      map[imageUrlKey] = imageUrl;
    }
    return map;
  }


}