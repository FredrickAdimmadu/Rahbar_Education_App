import 'package:cloud_firestore/cloud_firestore.dart';

class Agriculture {
  final String title;
  final String content;



  final String agricultureImages;
  final String video;
  final String youtube;
  final String email;



  final String id;
  final String name;
  final String agricultureId;
  final DateTime datePublished;
  final String agricultureUrl;




  const Agriculture({
    required this.title,
    required this.content,
    required this.agricultureImages,
    required this.video,
    required this.youtube,
    required this.email,

    required this.id,
    required this.name,
    required this.agricultureId,
    required this.datePublished,
    required this.agricultureUrl,


  });

  static Agriculture fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Agriculture(
      title: snapshot["title"] ?? "",
      content: snapshot["content"] ?? "",



      agricultureImages: snapshot["agricultureImages"] ?? "",
      video: snapshot["video"] ?? "",
      youtube: snapshot["youtube"] ?? "",
      email: snapshot["email"] ?? "",
      id: snapshot["id"] ,
      name: snapshot["name"] ,
      agricultureId: snapshot["agricultureId"] ,
      datePublished: (snapshot["datePublished"] as Timestamp?)?.toDate() ?? DateTime.now(),
      agricultureUrl: snapshot["agricultureUrl"],



    );
  }

  Map<String, dynamic> toJson() => {
    "content": content,
    "title": title,
    "agricultureImages" : agricultureImages,
    "video" : video,
    "youtube" : youtube,
    "email" : email,
    "id": id,
    "name": name,
    "agricultureId": agricultureId,
    "datePublished": datePublished,
    "agricultureUrl": agricultureUrl,
  };
}
