import 'package:cloud_firestore/cloud_firestore.dart';

class Dataanalysis {
  final String title;
  final String content;



  final String dataanalysisImages;
  final String video;
  final String youtube;
  final String email;



  final String id;
  final String name;
  final String dataanalysisId;
  final DateTime datePublished;
  final String dataanalysisUrl;




  const Dataanalysis({
    required this.title,
    required this.content,
    required this.dataanalysisImages,
    required this.video,
    required this.youtube,
    required this.email,

    required this.id,
    required this.name,
    required this.dataanalysisId,
    required this.datePublished,
    required this.dataanalysisUrl,


  });

  static Dataanalysis fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Dataanalysis(
      title: snapshot["title"] ?? "",
      content: snapshot["content"] ?? "",



      dataanalysisImages: snapshot["dataanalysisImages"] ?? "",
      video: snapshot["video"] ?? "",
      youtube: snapshot["youtube"] ?? "",
      email: snapshot["email"] ?? "",
      id: snapshot["id"] ,
      name: snapshot["name"] ,
      dataanalysisId: snapshot["dataanalysisId"] ,
      datePublished: (snapshot["datePublished"] as Timestamp?)?.toDate() ?? DateTime.now(),
      dataanalysisUrl: snapshot["dataanalysisUrl"],



    );
  }

  Map<String, dynamic> toJson() => {
    "content": content,
    "title": title,
    "dataanalysisImages" : dataanalysisImages,
    "video" : video,
    "youtube" : youtube,
    "email" : email,
    "id": id,
    "name": name,
    "dataanalysisId": dataanalysisId,
    "datePublished": datePublished,
    "dataanalysisUrl": dataanalysisUrl,
  };
}
