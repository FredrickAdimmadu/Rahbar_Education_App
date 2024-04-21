import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../navigate.dart';
import '../../providers/user_provider.dart';
import '../../resources/firestore_methods.dart';
import '../../utils/utils.dart';
import '../admin_dashboard.dart';

class ProgrammingAdmin extends StatefulWidget {
  const ProgrammingAdmin({Key? key}) : super(key: key);

  @override
  State<ProgrammingAdmin> createState() => _ProgrammingAdminState();
}

class _ProgrammingAdminState extends State<ProgrammingAdmin> {
  Uint8List? _file;
  List<Uint8List> _programmingImages = [];
  Uint8List? _video;
  VideoPlayerController? _videoController;
  bool isLoading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final Uint8List imageData = await image.readAsBytes();
        setState(() => _file = imageData);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future pickImage2() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null) {
        final List<Uint8List> imageDatas = await Future.wait(images.map((image) => image.readAsBytes()));
        setState(() => _programmingImages = imageDatas);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future pickVideo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      final Uint8List videoData = await video.readAsBytes();
      setState(() {
        _video = videoData;
        _videoController = VideoPlayerController.network(video.path)
          ..initialize().then((_) {
            setState(() {});
            if (_videoController != null) {
              _videoController!.play();
              _videoController!.setLooping(true);
            }
          });
      });
    }
  }

  Future<String> uploadFile(Uint8List fileData, String path) async {
    Reference storageRef = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = storageRef.putData(fileData);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void postImage() async {
  //   if (_file != null) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //
  //     try {
  //       String name = 'Rahbar';
  //       List<String> imageUrls = [];
  //       for (var imageFile in _programmingImages) {
  //         String path = 'programmingImages/${DateTime.now().millisecondsSinceEpoch}';
  //         String imageUrl = await uploadFile(imageFile, path);
  //         imageUrls.add(imageUrl);
  //       }
  //
  //       String? videoUrl;
  //       if (_video != null) {
  //         String videoPath = 'programmingVideo/${DateTime.now().millisecondsSinceEpoch}';
  //         videoUrl = await uploadFile(_video!, videoPath);
  //       }
  //
  //       String res = await FireStoreMethods.uploadProgramming(
  //         name,
  //         _emailController.text,
  //         _youtubeController.text,
  //         videoUrl ?? "",
  //         imageUrls.join(","),
  //         _titleController.text,
  //         _contentController.text,
  //         _file!,
  //       );
  //
  //       if (res == "success") {
  //         clearImage();
  //       } else {
  //         showSnackBar(context, res);
  //       }
  //     } catch (err) {
  //       showSnackBar(context, err.toString());
  //     } finally {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   } else {
  //     showSnackBar(context, "No featured image selected!");
  //   }
  // }
  //
  // void clearImage() {
  //   setState(() {
  //     _file = null;
  //   });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _emailController.dispose();
    _youtubeController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AdminDashboardPage(),
            ));
          },
        ),
        title: const Text('Post a Programming Book'),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: postImage,
            child: const Text(
              "Upload",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              isLoading
                  ? const LinearProgressIndicator()
                  : const Padding(padding: EdgeInsets.only(top: 0.0)),
              const Divider(),
              _file != null
                  ? Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(_file!),
                  ),
                ),
              )
                  : OutlinedButton(
                onPressed: pickImage,
                child: const Text('Pick Featured Image'),
              ),
              _programmingImages.isNotEmpty
                  ? CarouselSlider.builder(
                itemCount: _programmingImages.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Container(
                  child: Image.memory(_programmingImages[itemIndex], fit: BoxFit.cover),
                ),
                options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                ),
              )
                  : const SizedBox(),
              if (_videoController != null && _videoController!.value.isInitialized)
                AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                )
              else
                Container(), // Placeholder when no video is selected
              SizedBox(height: 20), // Provide some spacing
              ElevatedButton(
                onPressed: pickVideo,
                child: const Text('Pick Programming Video. <60 Seconds'),
              ),
              ElevatedButton(
                onPressed: pickImage2,
                child: const Text('Pick Programming Image or x3 Images'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: "Enter Title",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 16.0),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _contentController,
                        decoration: const InputDecoration(
                          hintText: "Write your Contents ",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: null,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter Email Address",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _youtubeController,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Youtube Url",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.url,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),
              const Text('Make an programming post: Fredrrick Adimmadu'),
            ],
          ),
        ),
      ),
    );
  }
}
