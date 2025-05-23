import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:image/image.dart' as img;

class YoloService {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    final modelPath = 'assets/models/yolov5s-fp16-320.tflite';
    _interpreter = await Interpreter.fromAsset(modelPath);
  }

  List<dynamic> detectObjects(Uint8List imageBytes) {
    final image = img.decodeImage(imageBytes);
    if (image == null) return [];

    final inputSize = 640;
    final resized = img.copyResize(image, width: inputSize, height: inputSize);

    final input = List.generate(
        inputSize,
        (y) => List.generate(
            inputSize,
            (x) => [
                  resized.getPixel(x, y).r / 255.0,
                  resized.getPixel(x, y).g / 255.0,
                  resized.getPixel(x, y).b / 255.0,
                ]));

    final inputTensor = [input];

    var output = List.filled(1 * 25200 * 85, 0.0).reshape([1, 25200, 85]);
    _interpreter.run(inputTensor, output);

    return output;
  }
}