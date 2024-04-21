import 'package:cloud_firestore/cloud_firestore.dart';

class Coaching {
  final String title;
  final String content;



  final String coachingImages;
  final String video;
  final String youtube;
  final String email;



  final String id;
  final String name;
  final String coachingId;
  final DateTime datePublished;
  final String coachingUrl;




  const Coaching({
    required this.title,
    required this.content,
    required this.coachingImages,
    required this.video,
    required this.youtube,
    required this.email,

    required this.id,
    required this.name,
    required this.coachingId,
    required this.datePublished,
    required this.coachingUrl,


  });

  static Coaching fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Coaching(
      title: snapshot["title"] ?? "",
      content: snapshot["content"] ?? "",



      coachingImages: snapshot["coachingImages"] ?? "",
      video: snapshot["video"] ?? "",
      youtube: snapshot["youtube"] ?? "",
      email: snapshot["email"] ?? "",
      id: snapshot["id"] ,
      name: snapshot["name"] ,
      coachingId: snapshot["coachingId"] ,
      datePublished: (snapshot["datePublished"] as Timestamp?)?.toDate() ?? DateTime.now(),
      coachingUrl: snapshot["coachingUrl"],



    );
  }

  Map<String, dynamic> toJson() => {
    "content": content,
    "title": title,
    "coachingImages" : coachingImages,
    "video" : video,
    "youtube" : youtube,
    "email" : email,
    "id": id,
    "name": name,
    "coachingId": coachingId,
    "datePublished": datePublished,
    "coachingUrl": coachingUrl,
  };
}
