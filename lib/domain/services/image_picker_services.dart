import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerServices {
  final _picker = ImagePicker();

  Future<void> pickImage(ImageSource source, Function(File) onPick) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        onPick(File(pickedFile.path));
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
