import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PageUpload extends StatefulWidget {
  PageUpload({super.key});

  @override
  _PageUploadState createState() => _PageUploadState();
}

class _PageUploadState extends State<PageUpload> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // SizedBox(height: 20),
          _selectedImage != null
              ? Image.file(_selectedImage!)
              : const Center(
                child: Text('No image selected')
                ),
               Center(
                child: ElevatedButton(
                          onPressed: _pickImageFromGallery,
                          child:const Text('Pick Image from Gallery'),
                        ),
              )
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
