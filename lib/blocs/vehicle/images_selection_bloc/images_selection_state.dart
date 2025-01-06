part of 'images_selection_bloc.dart';

final class ImagesSelectionState {
  final List<dynamic> images;
  final List<String> deletedLinks;
  final int maxLength;

  const ImagesSelectionState({
    required this.images,
    required this.deletedLinks,
    required this.maxLength,
  });

  ImagesSelectionState copyWith({
    List<dynamic>? images,
    List<String>? deletedLinks,
    int? maxLength,
  }) {
    return ImagesSelectionState(
      images: images ?? this.images,
      deletedLinks: deletedLinks ?? this.deletedLinks,
      maxLength: maxLength ?? this.maxLength,
    );
  }

  @override
  List<Object> get props => [images, deletedLinks, maxLength];
}
