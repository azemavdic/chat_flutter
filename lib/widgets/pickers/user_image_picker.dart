import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      if (pickedImage != null) {
        _pickedImage = pickedImageFile;
      } else {
        print('Nije odabrana slika');
      }
    });

    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
      ),
      TextButton.icon(
        onPressed: _pickImage,
        icon: const Icon(Icons.image),
        label: const Text('Dodaj sliku'),
      )
    ]);
  }
}
