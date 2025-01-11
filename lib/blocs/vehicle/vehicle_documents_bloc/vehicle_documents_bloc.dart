import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_documents_event.dart';
part 'vehicle_documents_state.dart';

class VehicleDocumentsBloc
    extends Bloc<VehicleDocumentsEvent, VehicleDocumentsState> {
  final int maxLength;
  final List<dynamic>? images;

  VehicleDocumentsBloc({required this.maxLength, this.images})
      : super(VehicleDocumentsState(
            images: images ?? [], deletedLinks: [], maxLength: maxLength)) {
    on<AddDocumentFileImage>(_onAddFileImage);
    on<RemoveDocumentImage>(_onRemoveImage);
  }

  void _onAddFileImage(
      AddDocumentFileImage event, Emitter<VehicleDocumentsState> emit) {
    emit(state.copyWith(images: [...state.images, event.image]));
  }

  void _onRemoveImage(
      RemoveDocumentImage event, Emitter<VehicleDocumentsState> emit) {
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
