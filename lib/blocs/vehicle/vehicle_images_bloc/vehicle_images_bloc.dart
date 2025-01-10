import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_images_event.dart';
part 'vehicle_images_state.dart';

class VehicleImagesBloc extends Bloc<VehicleImagesEvent, VehicleImagesState> {
  final int maxLength;
  final List<dynamic>? images;

  VehicleImagesBloc({required this.maxLength, this.images})
      : super(VehicleImagesState(
            images: images ?? [], deletedLinks: [], maxLength: maxLength)) {
    on<AddFileImage>(_onAddFileImage);
    on<RemoveImage>(_onRemoveImage);
  }

  void _onAddFileImage(AddFileImage event, Emitter<VehicleImagesState> emit) {
    emit(state.copyWith(images: [...state.images, event.image]));
  }

  void _onRemoveImage(RemoveImage event, Emitter<VehicleImagesState> emit) {
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
