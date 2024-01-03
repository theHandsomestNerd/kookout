import 'package:cookowt/models/hash_tag.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable_v3/detector/detector.dart';

List<Hashtag> extractHashTagWithDetails(String value) {
  const decoratedTextColor = Colors.blue;
  final detector = Detector(
      textStyle: const TextStyle(),
      decoratedStyle: const TextStyle(color: decoratedTextColor));
  final detections = detector.getDetections(value);
  final taggedDetections = detections
      .where((detection) => detection.style!.color == decoratedTextColor)
      .toList();
  final result = taggedDetections.map((decoration) {
    final text = decoration.range.textInside(value);
    return Hashtag.fromJson({"start": decoration.range.start, "end": decoration.range.end, "text": text.trim()});
  }).toList();
  return result;
}