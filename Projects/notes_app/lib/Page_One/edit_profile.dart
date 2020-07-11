import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/Authentication/auth.dart';
import 'package:notes_app/Page_One/page_One.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  bool editMode = true;
  String newUsername;
  File imageFile;

  Future<void> saveForm() async {
    final _validation = _formkey.currentState.validate();
    if (!_validation) {
      return;
    }
    _formkey.currentState.save();

    await Provider.of<Auth>(context).updateUserName(newUsername).then(
      (_) {
        setState(
          () {
            editMode = false;
          },
        );
      },
    );
  }

  Future<void> pickImage() async {
    File newImage;

    newImage =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    setState(() {
      imageFile = newImage;
    });

    final ref =
        FirebaseStorage.instance.ref().child("imageStorage").child("m1");

    await ref.putFile(imageFile).onComplete;
  }

  @override
  Widget build(BuildContext context) {
    return editMode == false
        ? PageOne()
        : Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 20,
                  bottom: 0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: pickImage,
                          child: CircleAvatar(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: imageFile == null
                                    ? Image.network(
                                        "https://pwcenter.org/sites/default/files/default_images/default_profile.png")
                                    : Image.file(
                                        imageFile,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      )),
                            backgroundColor: Theme.of(context).accentColor,
                            maxRadius: 60.0,
                          ),
                        ),
                        Consumer<Auth>(
                          builder: (ctx, provider, _) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 55.0, left: 13.0, bottom: 0.0),
                              child: TextFormField(
                                cursorColor: Theme.of(context).accentColor,
                                onSaved: (value) => newUsername = value,
                                initialValue: provider.username,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 26),
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter a valid username";
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                bottom: 70.0, right: 20.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.check,
                                color: Theme.of(context).accentColor,
                              ),
                              onPressed: saveForm,
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 120.0,
                        top: 0.0,
                      ),
                      child: Container(
                        height: 2,
                        width: 200,
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
