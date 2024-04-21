import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  final String title;
  final String content;



  final String medicineImages;
  final String video;
  final String youtube;
  final String email;



  final String id;
  final String name;
  final String medicineId;
  final DateTime datePublished;
  final String medicineUrl;




  const Medicine({
    required this.title,
    required this.content,
    required this.medicineImages,
    required this.video,
    required this.youtube,
    required this.email,

    required this.id,
    required this.name,
    required this.medicineId,
    required this.datePublished,
    required this.medicineUrl,


  });

  static Medicine fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Medicine(
      title: snapshot["title"] ?? "",
      content: snapshot["content"] ?? "",



      medicineImages: snapshot["medicineImages"] ?? "",
      video: snapshot["video"] ?? "",
      youtube: snapshot["youtube"] ?? "",
      email: snapshot["email"] ?? "",
      id: snapshot["id"] ,
      name: snapshot["name"] ,
      medicineId: snapshot["medicineId"] ,
      datePublished: (snapshot["datePublished"] as Timestamp?)?.toDate() ?? DateTime.now(),
      medicineUrl: snapshot["medicineUrl"],



    );
  }

  Map<String, dynamic> toJson() => {
    "content": content,
    "title": title,
    "medicineImages" : medicineImages,
    "video" : video,
    "youtube" : youtube,
    "email" : email,
    "id": id,
    "name": name,
    "medicineId": medicineId,
    "datePublished": datePublished,
    "medicineUrl": medicineUrl,
  };
}
