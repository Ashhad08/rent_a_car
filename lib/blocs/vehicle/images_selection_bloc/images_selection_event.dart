part of 'images_selection_bloc.dart';

sealed class ImagesSelectionEvent extends Equatable {
  const ImagesSelectionEvent();
}

final class AddFileImage extends ImagesSelectionEvent {
  final File image;

  const AddFileImage(this.image);

  @override
  List<Object?> get props => [image];
}

final class RemoveImage extends ImagesSelectionEvent {
  final dynamic image;

  const RemoveImage({required this.image});

  @override
  List<Object?> get props => [image];
}
