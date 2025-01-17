import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../configurations/backend_configs.dart';
import '../../network/network_repository.dart';

class ImageServices {
  final NetworkRepository _networkRepository;
  final BackendConfigs _backEndConfigs;

  ImageServices(this._networkRepository, this._backEndConfigs);

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

  Future<List<String>> uploadImages(List<String> images) async {
    try {
      if (images.isEmpty) return [];
      final res = await _networkRepository.postFormData(
        uri: _backEndConfigs.buildUri(
          segments: ['upload-multiple'],
        ),
        fileFieldName: 'files',
        filePaths: images,
      );
      return (res['files'] as Iterable).map((e) => e['url'] as String).toList();
    } catch (e) {
      rethrow;
    }
  }
}
