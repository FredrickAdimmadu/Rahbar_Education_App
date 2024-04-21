import 'package:cloud_firestore/cloud_firestore.dart';

class Music {
  final String title;
  final String content;



  final String musicImages;
  final String video;
  final String youtube;
  final String email;



  final String id;
  final String name;
  final String musicId;
  final DateTime datePublished;
  final String musicUrl;




  const Music({
    required this.title,
    required this.content,
    required this.musicImages,
    required this.video,
    required this.youtube,
    required this.email,

    required this.id,
    required this.name,
    required this.musicId,
    required this.datePublished,
    required this.musicUrl,


  });

  static Music fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Music(
      title: snapshot["title"] ?? "",
      content: snapshot["content"] ?? "",



      musicImages: snapshot["musicImages"] ?? "",
      video: snapshot["video"] ?? "",
      youtube: snapshot["youtube"] ?? "",
      email: snapshot["email"] ?? "",
      id: snapshot["id"] ,
      name: snapshot["name"] ,
      musicId: snapshot["musicId"] ,
      datePublished: (snapshot["datePublished"] as Timestamp?)?.toDate() ?? DateTime.now(),
      musicUrl: snapshot["musicUrl"],



    );
  }

  Map<String, dynamic> toJson() => {
    "content": content,
    "title": title,
    "musicImages" : musicImages,
    "video" : video,
    "youtube" : youtube,
    "email" : email,
    "id": id,
    "name": name,
    "musicId": musicId,
    "datePublished": datePublished,
    "musicUrl": musicUrl,
  };
}
