part of 'vehicle_documents_bloc.dart';

final class VehicleDocumentsState extends Equatable {
  final List<dynamic> images;
  final List<String> deletedLinks;
  final int maxLength;

  const VehicleDocumentsState({
    required this.images,
    required this.deletedLinks,
    required this.maxLength,
  });

  VehicleDocumentsState copyWith({
    List<dynamic>? images,
    List<String>? deletedLinks,
    int? maxLength,
  }) {
    return VehicleDocumentsState(
      images: images ?? this.images,
      deletedLinks: deletedLinks ?? this.deletedLinks,
      maxLength: maxLength ?? this.maxLength,
    );
  }

  @override
  List<Object> get props => [images, deletedLinks, maxLength];
}
