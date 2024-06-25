import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImagePickerExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage(File image) async {
    String uploadUrl = 'http://10.0.2.2:5000/upload'; // Use emulator-specific address

    final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');

    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(uploadUrl));
    final file = await http.MultipartFile.fromPath(
      'image',
      image.path,
      contentType: MediaType(mimeTypeData![0], mimeTypeData[1]), // Use MediaType from http_parser
    );

    imageUploadRequest.files.add(file);

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Image Picker Example'),
      ),
      body:Center(
        child:_image==null?
        Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedColor: Colors.black,
                selected: true,
            ),
            Divider(),
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
            ),
            Divider(),
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
            ),
            Divider(),
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
            ),
            Divider(),
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
            ),
            Divider(),
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
            ),
            Divider(),
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
            ),
            Divider(),
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
            ),
            Divider(),
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
            ),
            Divider(),
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
            ),
            Divider(),
            ListTile(
                title: Text('ListTile with FadeTransition'),
                selectedTileColor: Colors.green,
                selectedColor: Colors.white,
                selected: true,
            ),
            ],
          ),
        ),
      )
      :Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(_image!),
                  ElevatedButton(
                    onPressed: () => _uploadImage(_image!),
                    child: Text('Upload Image'),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape:const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon:const Icon(Icons.photo_library),
                onPressed: () => _pickImage(ImageSource.gallery),
                tooltip: 'Pick Image from Gallery',
              ),
              IconButton(
                icon:const Icon(Icons.home),
                onPressed: () => ImagePickerExample(),
                tooltip: 'Home',
              ),
              IconButton(
                icon:const Icon(Icons.camera_alt),
                onPressed: () => _pickImage(ImageSource.camera),
                tooltip: 'Take a Photo',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Page_upload extends  StatelessWidget{
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title:const Center(
        child:Text("Upload_Image"),
      ),
    ),
    body:const Center(
      child:Column(

      ),
    ),
  );
  }
}
