import 'dart:io';
import 'package:biolinktree_assignment/data_models/userModel.dart';
import 'package:biolinktree_assignment/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateProfileScreen extends StatefulWidget {
  CreateProfileScreen({Key? key}) : super(key: key);

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedProfileImg;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String? _theDlUrl;
  bool _isLoading = false;

  final _formGlobalKey = GlobalKey<FormState>(); // the form key

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _linkGitHub = TextEditingController();
  final TextEditingController _linkStackOverFlow = TextEditingController();
  final TextEditingController _linkLinkedIn = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _authProvider = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create your profile'),
      ),
      body: Container(
        // padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            _selectedProfileImg == null
                ? Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(color: Colors.blue),
                  )
                : Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: _selectedProfileImg == null ? Colors.blue : null,
                      image: DecorationImage(
                        image: FileImage(
                          File(_selectedProfileImg!.path),
                        ),
                      ),
                    ),
                  ),
            ElevatedButton(
                onPressed: () async {
                  // add image picker package
                  _selectedProfileImg =
                      await _imagePicker.pickImage(source: ImageSource.gallery);

                  // debugPrint("===========>>>" + _selectedProfileImg!.path);
                  setState(() {});
                  // pick an image from the gallery
                },
                child: Text('select profile image')),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Form(
                  key: _formGlobalKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        decoration: generalInputDecoration(labelText: 'name'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _titleController,
                        decoration: generalInputDecoration(labelText: 'title'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _contactController,
                        decoration:
                            generalInputDecoration(labelText: 'phone Number'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'the phone number is required';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _bioController,
                        decoration: generalInputDecoration(labelText: 'bio'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _locationController,
                        decoration:
                            generalInputDecoration(labelText: 'location'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _linkGitHub,
                        decoration:
                            generalInputDecoration(labelText: 'GitHub link'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _linkStackOverFlow,
                        decoration: generalInputDecoration(
                            labelText: 'StackOverFlow link'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _linkLinkedIn,
                        decoration:
                            generalInputDecoration(labelText: 'LinkedIn link'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: 60,
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                  debugPrint(_isLoading.toString());
                                });

                                bool _isValidated =
                                    _formGlobalKey.currentState!.validate();

                                if (_isValidated == true &&
                                    _authProvider.theUser != null) {
                                  await uploadTheSelectedFile(
                                      _authProvider.theUser!.uid);
                                  //make our job easier
                                  UserModel _generalUser = UserModel(
                                    userId: _authProvider.theUser!.uid,
                                    email: _authProvider.theUser!.email,
                                    userName: _userNameController.value.text,
                                    phone: _contactController.value.text,
                                    bio: _bioController.value.text,
                                    location: _locationController.value.text,
                                    linkGitHub: _linkGitHub.value.text,
                                    linkStakOverFlow:
                                        _linkStackOverFlow.value.text,
                                    linkLinkedIn: _linkLinkedIn.value.text,
                                    title: _titleController.value.text,
                                    profileImg: _theDlUrl,
                                    isLookingForJob: false,
                                  );

                                  await FirebaseFirestore.instance
                                      .collection('users_linktree')
                                      .doc(_authProvider.theUser!.uid)
                                      .set(_generalUser.toMap(),
                                          SetOptions(merge: true))
                                      .then((value) {
                                    setState(() {
                                      _isLoading = false;
                                      debugPrint(_isLoading.toString());
                                    });
                                    Navigator.pushNamed(context, '/');
                                  });
                                }
                              },
                              child: Text('Create it!'))),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration generalInputDecoration(
      {required String labelText, String? hintText}) {
    return InputDecoration(
      label: Text(labelText),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Future<String?> uploadTheSelectedFile(String uid) async {
    //selected image as file
    File _theImageFile = File(_selectedProfileImg!.path);

    //upload the selected image
    await _firebaseStorage
        .ref()
        .child('users/$uid')
        .putFile(_theImageFile)
        .then((p) async {
      _theDlUrl = await p.ref.getDownloadURL();
      debugPrint("dl =======> " + _theDlUrl!);
    });
    return _theDlUrl;
    //todo remove this if for production
    //recieve the downloadURL for the image
  }
}
