import 'package:cloud_firestore/cloud_firestore.dart';

class Programming {
  final String title;
  final String content;
  final String programmingImages;
  final String video;
  final String youtube;
  final String email;
//  final String id;
  final String name;
  final String programmingId;
  final DateTime datePublished;
  final String programmingUrl;




  const Programming({
    required this.title,
    required this.content,
    required this.programmingImages,
    required this.video,
    required this.youtube,
    required this.email,

  //  required this.id,
    required this.name,
    required this.programmingId,
    required this.datePublished,
    required this.programmingUrl,


  });

  static Programming fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Programming(
      title: snapshot["title"] ?? "",
      content: snapshot["content"] ?? "",



      programmingImages: snapshot["programmingImages"] ?? "",
      video: snapshot["video"] ?? "",
      youtube: snapshot["youtube"] ?? "",
      email: snapshot["email"] ?? "",
    //  id: snapshot["id"] ,
      name: snapshot["name"] ,
      programmingId: snapshot["programmingId"] ,
      datePublished: (snapshot["datePublished"] as Timestamp?)?.toDate() ?? DateTime.now(),
      programmingUrl: snapshot["programmingUrl"],



    );
  }

  Map<String, dynamic> toJson() => {
    "content": content,
    "title": title,
    "programmingImages" : programmingImages,
    "video" : video,
    "youtube" : youtube,
    "email" : email,
    //"id": id,
    "name": name,
    "programmingId": programmingId,
    "datePublished": datePublished,
    "programmingUrl": programmingUrl,
  };
}
