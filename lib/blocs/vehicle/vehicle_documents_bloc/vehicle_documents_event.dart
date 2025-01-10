part of 'vehicle_documents_bloc.dart';

sealed class VehicleDocumentsEvent extends Equatable {
  const VehicleDocumentsEvent();
}

final class AddDocumentFileImage extends VehicleDocumentsEvent {
  final dynamic image;

  const AddDocumentFileImage({required this.image});

  @override
  List<Object?> get props => [image];
}

final class RemoveDocumentImage extends VehicleDocumentsEvent {
  final dynamic image;

  const RemoveDocumentImage({required this.image});

  @override
  List<Object?> get props => [image];
}
