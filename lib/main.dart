import 'package:flutter/material.dart';
import 'package:future_and_stream_builder/screen/home_screen_stream.dart';
import 'package:future_and_stream_builder/screen/home_screen_future.dart';

void main() {
  runApp(
    MaterialApp(
      // home: HomeScreenFuture(),
      home: HomeScreenStream(),
    ),
  );
}
