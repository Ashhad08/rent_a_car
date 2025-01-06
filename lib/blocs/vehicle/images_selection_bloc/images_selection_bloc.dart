import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'images_selection_event.dart';
part 'images_selection_state.dart';

class ImagesSelectionBloc
    extends Bloc<ImagesSelectionEvent, ImagesSelectionState> {
  final int maxLength;
  final List<dynamic>? images;

  ImagesSelectionBloc({required this.maxLength, this.images})
      : super(ImagesSelectionState(
            images: images ?? [], deletedLinks: [], maxLength: maxLength)) {
    on<AddFileImage>(_onAddFileImage);
    on<RemoveImage>(_onRemoveImage);
  }

  void _onAddFileImage(AddFileImage event, Emitter<ImagesSelectionState> emit) {
    emit(state.copyWith(images: [...state.images, event.image]));
  }

  void _onRemoveImage(RemoveImage event, Emitter<ImagesSelectionState> emit) {
    final updatedImages = List<dynamic>.from(state.images);
    final updatedDeletedLinks = List<String>.from(state.deletedLinks);

    if (event.image is String && state.images.contains(event.image)) {
      updatedDeletedLinks.add(event.image);
    }
    updatedImages.remove(event.image);

    emit(state.copyWith(
        images: updatedImages, deletedLinks: updatedDeletedLinks));
  }
}
