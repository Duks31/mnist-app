import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mnist_app/dl_model/classifier.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  Classifier classifier = Classifier();
  late File imageFile;
  int digit = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'png'],
          );
          if (result != null) {
            imageFile = await File(result.files.single.path!);
            digit = await classifier.classifyImage(imageFile);
            setState(() {});
          }
        },
        child: Icon(Icons.camera_alt_outlined),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text("Best Digit Recognizer in the World")),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Image will be shown Below ",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2.0),
                image: DecorationImage(
                  image: digit == -1
                      ? AssetImage("assets/white_bg.jfif") as ImageProvider
                      : FileImage(imageFile),
                ),
              ),
            ),
            SizedBox(height: 45),
            Text(
              "Current Prediction: ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              digit == -1 ? "" : "$digit",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

