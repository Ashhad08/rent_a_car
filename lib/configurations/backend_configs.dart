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
  final _createVoucher = 'create-receipt';
  final _updateVoucher = 'edit-receipt';

  get createVoucher => _createVoucher;

  String get vehicle => _vehicle;
  final _expense = 'expense';

  get expense => _expense;
  final _addExpense = 'add-expense';

  get addExpense => _addExpense;
  final _updateExpense = 'edit-expense';

  get updateExpense => _updateExpense;
  final _deleteExpense = 'delete-expense';

  get allHeads => _allHeads;
  final _allHeads = 'all-expense-head';

  final _dashboardAllData = 'all-data';
  final _dashboard = 'dashboard';

  get dashboard => _dashboard;

  get dashboardAllData => _dashboardAllData;
  final _unassignedVehicles = 'un-assign-car';

  get unassignedVehicles => _unassignedVehicles;

  String get editOwner => _editOwner;
  final _vehicleAllColors = 'all-colors';
  final _addVehicle = 'add-vehicle';
  final _updateVehicle = 'edit-vehicle';

  get updateVehicle => _updateVehicle;
  final _availableVehicle = 'available-vehicle';

  get availableVehicle => _availableVehicle;

  get addVehicle => _addVehicle;
  final _vehicleAllFeatures = 'all-features';
  final _allPaymentVouchers = 'all-receipts';

  get allPaymentVouchers => _allPaymentVouchers;
  final _vehicleAllMakes = 'all-makes';

  get vehicleAllMakes => _vehicleAllMakes;
  final _vehicleAllFuels = 'all-fuels';
  final _vehicleUpdateFuel = 'edit-fuel';

  get vehicleUpdateFuel => _vehicleUpdateFuel;

  get vehicleAllFuels => _vehicleAllFuels;
  final _vehicleAllTypes = 'all-types';
  final _vehicleAllModels = 'all-model';
  final _vehicleSingleModels = 'single-model';

  final _booking = 'booking';
  final _createBooking = 'create-booking';
  final _pendingBookings = 'pending-bookings';
  final _approvedBookings = 'approved-bookings';
  final _bookingsByCustomer = 'user-bookings';

  get bookingsByCustomer => _bookingsByCustomer;

  get approvedBookings => _approvedBookings;

  get pendingBookings => _pendingBookings;
  final _editBooking = 'edit-booking';

  get booking => _booking;
  final _randomId = 'random-id';

  get randomId => _randomId;

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

  get createBooking => _createBooking;

  get editBooking => _editBooking;

  get updateVoucher => _updateVoucher;

  get deleteExpense => _deleteExpense;
}
