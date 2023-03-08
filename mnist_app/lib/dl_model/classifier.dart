import 'dart:io' as io;
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  Classifier();

  classifyImage(File) async {
    // getting the file to Unint8
    var file = io.File(File.path);
    img.Image? imageTemp =  img.decodeImage(file.readAsBytesSync());
    img.Image resiezedImg =  img.copyResize(imageTemp!, height: 28, width: 28);
    var imgBytes = resiezedImg.getBytes();
    var imgAsList = imgBytes.buffer.asUint8List();
    return getPred(imgAsList);
  }

  Future<int> getPred(Uint8List imgAsList) async {
    // ignore: deprecated_member_use
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
    // ignore: deprecated_member_use
    var output = List.filled(1 * 10, null, growable: false).reshape([1, 10]);

    InterpreterOptions interpreterOptions = InterpreterOptions();

    try {
      Interpreter interpreter = await Interpreter.fromAsset("model.tflite",
          options: interpreterOptions);
      interpreter.run(input, output);
    } catch (e) {
      print("Error Loading Model");
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

