part of 'vehicle_images_bloc.dart';

sealed class VehicleImagesEvent extends Equatable {
  const VehicleImagesEvent();
}

final class AddFileImage extends VehicleImagesEvent {
  final dynamic image;

  const AddFileImage({required this.image});

  @override
  List<Object?> get props => [image];
}

final class RemoveImage extends VehicleImagesEvent {
  final dynamic image;

  const RemoveImage({required this.image});

  @override
  List<Object?> get props => [image];
}
