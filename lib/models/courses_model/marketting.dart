import 'package:cloud_firestore/cloud_firestore.dart';

class Marketting {
  final String title;
  final String content;



  final String markettingImages;
  final String video;
  final String youtube;
  final String email;



  final String id;
  final String name;
  final String markettingId;
  final DateTime datePublished;
  final String markettingUrl;




  const Marketting({
    required this.title,
    required this.content,
    required this.markettingImages,
    required this.video,
    required this.youtube,
    required this.email,

    required this.id,
    required this.name,
    required this.markettingId,
    required this.datePublished,
    required this.markettingUrl,


  });

  static Marketting fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Marketting(
      title: snapshot["title"] ?? "",
      content: snapshot["content"] ?? "",



      markettingImages: snapshot["markettingImages"] ?? "",
      video: snapshot["video"] ?? "",
      youtube: snapshot["youtube"] ?? "",
      email: snapshot["email"] ?? "",
      id: snapshot["id"] ,
      name: snapshot["name"] ,
      markettingId: snapshot["markettingId"] ,
      datePublished: (snapshot["datePublished"] as Timestamp?)?.toDate() ?? DateTime.now(),
      markettingUrl: snapshot["markettingUrl"],



    );
  }

  Map<String, dynamic> toJson() => {
    "content": content,
    "title": title,
    "markettingImages" : markettingImages,
    "video" : video,
    "youtube" : youtube,
    "email" : email,
    "id": id,
    "name": name,
    "markettingId": markettingId,
    "datePublished": datePublished,
    "markettingUrl": markettingUrl,
  };
}
