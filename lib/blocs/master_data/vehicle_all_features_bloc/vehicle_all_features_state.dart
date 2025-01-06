part of 'vehicle_all_features_bloc.dart';

sealed class VehicleAllFeaturesState extends Equatable {
  const VehicleAllFeaturesState();
}

final class VehicleAllFeaturesLoading extends VehicleAllFeaturesState {
  @override
  List<Object> get props => [];
}

final class VehicleAllFeaturesLoaded extends VehicleAllFeaturesState {
  final List<VehicleFeatureModel> _allFeatures;

  List<VehicleFeatureModel> get allFeatures => _allFeatures;

  const VehicleAllFeaturesLoaded(
      {required List<VehicleFeatureModel> allFeatures})
      : _allFeatures = allFeatures;

  @override
  List<Object> get props => [_allFeatures];
}

final class VehicleAllFeaturesError extends VehicleAllFeaturesState {
  final String _error;

  String get error => _error;

  const VehicleAllFeaturesError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
