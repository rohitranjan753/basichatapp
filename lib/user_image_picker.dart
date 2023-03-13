import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  var _pickedImage;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.getImage(source: ImageSource.camera,
    imageQuality: 50,
    maxWidth: 150,);
    setState(() {
      if(pickedImageFile != null) {
        _pickedImage = File(pickedImageFile.path);
      }
    });
    widget.imagePickFn(_pickedImage);
  }

  // void _pickImage() async {
  //   final picker = ImagePicker();
  //   //we can use dialog for option of gallery and camera
  //   final pickedImage = await picker.getImage(source: ImageSource.camera);
  //   final pickedImageFile = File(pickedImage!.path);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        FlatButton.icon(
          onPressed: () {
            _pickImage();
          },
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
