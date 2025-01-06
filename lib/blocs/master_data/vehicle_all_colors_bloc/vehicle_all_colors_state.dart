part of 'vehicle_all_colors_bloc.dart';

sealed class VehicleAllColorsState extends Equatable {
  const VehicleAllColorsState();
}

final class VehicleAllColorsLoading extends VehicleAllColorsState {
  @override
  List<Object> get props => [];
}

final class VehicleAllColorsLoaded extends VehicleAllColorsState {
  final List<ColorModel> _allColors;

  List<ColorModel> get allColors => _allColors;

  const VehicleAllColorsLoaded({required List<ColorModel> allColors})
      : _allColors = allColors;

  @override
  List<Object> get props => [_allColors];
}

final class VehicleAllColorsError extends VehicleAllColorsState {
  final String _error;

  String get error => _error;

  const VehicleAllColorsError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
