import 'package:cloud_firestore/cloud_firestore.dart';

class Politics {
  final String title;
  final String content;



  final String politicsImages;
  final String video;
  final String youtube;
  final String email;



  final String id;
  final String name;
  final String politicsId;
  final DateTime datePublished;
  final String politicsUrl;




  const Politics({
    required this.title,
    required this.content,
    required this.politicsImages,
    required this.video,
    required this.youtube,
    required this.email,

    required this.id,
    required this.name,
    required this.politicsId,
    required this.datePublished,
    required this.politicsUrl,


  });

  static Politics fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Politics(
      title: snapshot["title"] ?? "",
      content: snapshot["content"] ?? "",



      politicsImages: snapshot["politicsImages"] ?? "",
      video: snapshot["video"] ?? "",
      youtube: snapshot["youtube"] ?? "",
      email: snapshot["email"] ?? "",
      id: snapshot["id"] ,
      name: snapshot["name"] ,
      politicsId: snapshot["politicsId"] ,
      datePublished: (snapshot["datePublished"] as Timestamp?)?.toDate() ?? DateTime.now(),
      politicsUrl: snapshot["politicsUrl"],



    );
  }

  Map<String, dynamic> toJson() => {
    "content": content,
    "title": title,
    "politicsImages" : politicsImages,
    "video" : video,
    "youtube" : youtube,
    "email" : email,
    "id": id,
    "name": name,
    "politicsId": politicsId,
    "datePublished": datePublished,
    "politicsUrl": politicsUrl,
  };
}
