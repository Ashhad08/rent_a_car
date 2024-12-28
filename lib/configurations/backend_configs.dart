class BackendConfigs {
  final _baseUrl = 'https://rent-car-backend-iota.vercel.app/';

  get baseUrl => _baseUrl;

  final _allVehicles = 'vehicle-details';

  get allVehicles => _allVehicles;

  Uri buildUri({required List<dynamic> segments}) {
    return Uri.parse(
        '$baseUrl/${segments.map((e) => Uri.encodeComponent(e.toString())).join('/')}');
  }
}
