part of 'vehicle_images_bloc.dart';

final class VehicleImagesState extends Equatable {
  final List<dynamic> images;
  final List<String> deletedLinks;
  final int maxLength;

  const VehicleImagesState({
    required this.images,
    required this.deletedLinks,
    required this.maxLength,
  });

  VehicleImagesState copyWith({
    List<dynamic>? images,
    List<String>? deletedLinks,
    int? maxLength,
  }) {
    return VehicleImagesState(
      images: images ?? this.images,
      deletedLinks: deletedLinks ?? this.deletedLinks,
      maxLength: maxLength ?? this.maxLength,
    );
  }

  @override
  List<Object> get props => [images, deletedLinks, maxLength];
}
