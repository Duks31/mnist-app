import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:mnist_app/dl_model/classifier.dart';

class DrawPage extends StatefulWidget {
  @override
  _DrawPageState createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  Classifier classifier = Classifier();
  List<Offset> points = <Offset>[];
  final pointMode = ui.PointMode.points;
  int digit = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.close),
        onPressed: () {
          setState(() {
            points.clear();
            digit = -1;
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Best digit recognizer in the world"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text("Draw digit inside the box",
                style: TextStyle(fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 300 + 2 * 2,
              height: 300 + 2 * 2,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: GestureDetector(
                onPanUpdate: (DragUpdateDetails details) {
                  Offset localPosition = details.localPosition;
                  if (localPosition.dx >= 0 &&
                      localPosition.dx <= 300 &&
                      localPosition.dy >= 0 &&
                      localPosition.dy <= 300) {
                    setState(() {
                      points.add(localPosition);
                    });
                  }
                },
                onPanEnd: (DragEndDetails details) async {
                  points = points;
                  digit = await classifier.classifyDrawing(points);
                  setState(() {});
                },
                child: CustomPaint(
                  painter: Painter(points: points),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text("Current Prediction:",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            Text(digit == -1 ? "" : "$digit",
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final List<Offset> points;
  Painter({required this.points});

  final Paint _paintDetails = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth =
        4.0 // strokeWidth 4 looks good, but strokeWidth approx. 16 looks closer to training data
    ..color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], _paintDetails);
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    return true;
  }
}
