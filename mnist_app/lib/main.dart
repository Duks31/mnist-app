import 'package:flutter/material.dart';
import 'package:mnist_app/pages/upload_page.dart';

void main() {
  runApp(MyApp());  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List tabs = [
    UploadImage(),
    Center(child: Text("Drawing Page")),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
         currentIndex: currentIndex,
         unselectedFontSize: 14.0,
         selectedFontSize: 14.0,
         selectedItemColor: Colors.pink,
         unselectedItemColor: Colors.grey[400],
         items: [
          BottomNavigationBarItem(icon: Icon(Icons.image), 
          label: "Image"),
          BottomNavigationBarItem(icon: Icon(Icons.add_sharp), 
          label: "Draw"),
         ],
         onTap: (index) {
          setState(() {
          currentIndex = index;
          });
         },
      ),
    );
  }
}

