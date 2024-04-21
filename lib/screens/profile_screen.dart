import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../api/apis.dart';
import '../helper/dialogs.dart';
import '../helper/my_date_util.dart';
import '../main.dart';
import '../models/rahbar_user.dart';


class ProfileScreen extends StatefulWidget {
  final RahbarUser user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Profile Settins Screen')),
        
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(width: mq.size.width, height: mq.size.height * 0.03),
                    Stack(
                      children: [
                        _image != null
                            ? ClipRRect(
                          borderRadius:
                          BorderRadius.circular(mq.size.height * 0.1),
                          child: Image.file(
                            File(_image!),
                            width: mq.size.height * 0.2,
                            height: mq.size.height * 0.2,
                            fit: BoxFit.cover,
                          ),
                        )
                            : ClipRRect(
                          borderRadius:
                          BorderRadius.circular(mq.size.height * 0.1),
                          child: CachedNetworkImage(
                            width: mq.size.height * 0.2,
                            height: mq.size.height * 0.2,
                            fit: BoxFit.cover,
                            imageUrl: widget.user.image,
                            errorWidget: (context, url, error) =>
                            const CircleAvatar(
                              child: Icon(CupertinoIcons.person),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: MaterialButton(
                            elevation: 1,
                            onPressed: () {
                              _showBottomSheet();
                            },
                            shape: const CircleBorder(),
                            color: Colors.white,
                            child: const Icon(Icons.edit, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: mq.size.height * 0.03),
                    Text(
                      widget.user.email,
                      style: const TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    SizedBox(height: mq.size.height * 0.03),
                    Text(
                      'Joined On: ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      MyDateUtil.getLastMessageTime(
                        context: context,
                        time: widget.user.createdAt,
                        showYear: true,
                      ),
                      style: const TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    SizedBox(height: mq.size.height * 0.05),
                    TextFormField(
                      initialValue: widget.user.name,
                      onSaved: (val) => APIs.me.name = val ?? '',
                      validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'eg. Happy Singh',
                        label: const Text('Name'),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.02),
                    TextFormField(
                      initialValue: widget.user.about,
                      onSaved: (val) => APIs.me.about = val ?? '',
                      validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.info_outline, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'eg. Feeling Happy',
                        label: const Text('About'),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.05),
        
        
        
        
        
        
                    TextFormField(
                      initialValue: widget.user.number,
                      onSaved: (val) => APIs.me.number = val ?? '',
                      validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.call, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'eg. 068329',
                        label: const Text('Phone number'),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: mq.size.height * 0.02),
        
                    SizedBox(height: mq.size.height * 0.02),
                    TextFormField(
                      initialValue: widget.user.country,
                      onSaved: (val) => APIs.me.country = val ?? '',
                      validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.flag, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'eg. United Kingdom',
                        label: const Text('Country'),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.02),
                    TextFormField(
                      initialValue: widget.user.gender,
                      onSaved: (val) => APIs.me.gender = val ?? '',
                      validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                      decoration: InputDecoration(
                        prefixIcon:
                        const Icon(Icons.person_3_rounded, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'eg. Male',
                        label: const Text('Gender'),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.02),
                    TextFormField(
                      initialValue: widget.user.language,
                      onSaved: (val) => APIs.me.language = val ?? '',
                      validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.language, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'eg. English',
                        label: const Text('Language'),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.02),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: Size(mq.size.width * 0.5, mq.size.height * 0.06),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          APIs.updateUserInfo().then((value) {
                            Dialogs.showSnackbar(
                              context,
                              'Profile Updated Successfully!',
                            );
                          });
                        }
                      },
                      icon: const Icon(Icons.edit, size: 28),
                      label: const Text('UPDATE', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: mq.height * 0.03,
            bottom: mq.height * 0.05,
          ),
          children: [
            const Text(
              'Pick Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: mq.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(mq.width * 0.3, mq.height * 0.15),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      log('Image Path: ${image.path}');
                      setState(() {
                        _image = image.path;
                      });
                      APIs.updateProfilePicture(File(_image!));
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('images/add_image.png'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(mq.width * 0.3, mq.height * 0.15),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      log('Image Path: ${image.path}');
                      setState(() {
                        _image = image.path;
                      });
                      APIs.updateProfilePicture(File(_image!));
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('images/camera.png'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

