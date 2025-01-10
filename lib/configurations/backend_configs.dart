class BackendConfigs {
  final _baseUrl =
      'https://auditor-server-git-main-raamishshah010s-projects.vercel.app';

  get baseUrl => _baseUrl;
  final String _vehicle = 'vehicle';
  final String _owner = 'owner';
  final String _customer = 'customer';
  final String _promotion = 'promo';
  final String _addPromotion = 'add-promo';
  final String _updatePromotion = 'edit-promo';
  final String _deletePromotion = 'delete-promo';

  String get promotion => _promotion;

  String get customer => _customer;

  String get owner => _owner;
  final String _addOwner = 'add-owner';
  final String _editOwner = 'edit-owner';

  String get vehicle => _vehicle;

  String get editOwner => _editOwner;
  final _vehicleAllColors = 'all-colors';
  final _addVehicle = 'add-vehicle';
  final _availableVehicle = 'available-vehicle';

  get availableVehicle => _availableVehicle;

  get addVehicle => _addVehicle;
  final _vehicleAllFeatures = 'all-features';
  final _vehicleAllFuels = 'all-fuels';
  final _vehicleUpdateFuel = 'edit-fuel';

  get vehicleUpdateFuel => _vehicleUpdateFuel;

  get vehicleAllFuels => _vehicleAllFuels;
  final _vehicleAllTypes = 'all-types';
  final _vehicleAllModels = 'all-model';
  final _vehicleSingleModels = 'single-model';

  get vehicleSingleModels => _vehicleSingleModels;

  Uri buildUri({required List<dynamic> segments}) {
    return Uri.parse(
        '$baseUrl/${segments.map((e) => Uri.encodeComponent(e.toString())).join('/')}');
  }

  get vehicleAllColors => _vehicleAllColors;

  get vehicleAllFeatures => _vehicleAllFeatures;

  get vehicleAllTypes => _vehicleAllTypes;

  get vehicleAllModels => _vehicleAllModels;

  String get addOwner => _addOwner;

  String get addPromotion => _addPromotion;

  String get deletePromotion => _deletePromotion;

  String get updatePromotion => _updatePromotion;
}
