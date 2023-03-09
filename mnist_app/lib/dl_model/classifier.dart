import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  Classifier();


  classifyDrawing(List<Offset> points) async {
    // Takes img as a List of Points from Drawing and returns Integer
    // of which digit it was (hopefully)!

    // Ugly boilerplate to get it to Uint8List
    final picture = toPicture(points); // convert List to Picture
    final image = await picture.toImage(28, 28); // Picture to 28x28 Image
    ByteData? imgBytes = await image.toByteData(); // Read this image
    var imgAsList = imgBytes?.buffer.asUint8List();

    // Everything "important" is done in getPred
    return getPred(imgAsList!);
  }

  Future<int> getPred(Uint8List imgAsList) async {
    List resultBytes = List.filled(28 * 28, null, growable: false);

    int index = 0;

    for (int i = 0; i < imgAsList.lengthInBytes; i += 4) {
      final r = imgAsList[i];
      final g = imgAsList[i + 1];
      final b = imgAsList[i + 2];

      resultBytes[index] = ((r + g + b) / 3.0) / 255.0;
      index++;
    }

    var input = resultBytes.reshape([1, 28, 28, 1]);
    var output = List.filled(1 * 10, null, growable: false).reshape([1, 10]);

    InterpreterOptions interpreterOptions = InterpreterOptions();

    try {
      Interpreter interpreter = await Interpreter.fromAsset("model.tflite",
          options: interpreterOptions);
      interpreter.run(input, output);
    } catch (e) {
      // print("Error Loading Model");
    }

    double highesProb = 0;
    late int digitPred;

    for (int i = 0; i < output[0].length; i++) {
      if (output[0][i] > highesProb) {
        highesProb = output[0][i];
        digitPred = i;
      }
    }
    return digitPred;
  }
}

ui.Picture toPicture(List<Offset> points) {
  final _whitePaint = Paint()
    ..strokeCap = StrokeCap.round
    ..color = Colors.white
    ..strokeWidth = 16;

  final _bgPaint = Paint()..color = Colors.black;
  final _canvasCullRect = Rect.fromPoints(
    Offset(0, 0),
    Offset(28.0, 28.0),
  );
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, _canvasCullRect)..scale(28 / 300);

  canvas.drawRect(const Rect.fromLTWH(0, 0, 28, 28), _bgPaint);

  for (int i = 0; i < points.length - 1; i++) {
    if (points[i] != null && points[i + 1] != null) {
      canvas.drawLine(points[i], points[i + 1], _whitePaint);
    }
  }

  return recorder.endRecording();
}
