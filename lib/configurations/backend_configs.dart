class BackendConfigs {
  final _baseUrl =
      'url';

  get baseUrl => _baseUrl;

  final _vehicleAllColors = 'vehicle/all-colors';
  final _vehicleAllFeatures = 'vehicle/all-features';
  final _vehicleAllTypes = 'vehicle/all-types';
  final _vehicleAllModels = 'vehicle/all-model';

  Uri buildUri({required List<dynamic> segments}) {
    return Uri.parse(
        '$baseUrl/${segments.map((e) => Uri.encodeComponent(e.toString())).join('/')}');
  }

  get vehicleAllColors => _vehicleAllColors;

  get vehicleAllFeatures => _vehicleAllFeatures;

  get vehicleAllTypes => _vehicleAllTypes;

  get vehicleAllModels => _vehicleAllModels;
}
