import '../../../configurations/backend_configs.dart';
import '../../../network/network_repository.dart';
import '../../models/master_data/color_model.dart';
import '../../models/master_data/dashboard_model.dart';
import '../../models/master_data/expense_head_model.dart';
import '../../models/master_data/fuel_type_model.dart';
import '../../models/master_data/vehicle_feature_model.dart';
import '../../models/master_data/vehicle_make_model.dart';
import '../../models/master_data/vehicle_model_model.dart';
import '../../models/master_data/vehicle_type_model.dart';

abstract class BaseMasterDataRepository {
  final BackendConfigs _backendConfigs;

  BackendConfigs get backendConfigs => _backendConfigs;
  final NetworkRepository _networkRepository;

  BaseMasterDataRepository(
      {required BackendConfigs backendConfigs,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _networkRepository = networkRepository;

  Future<List<ColorModel>> getVehicleAllColors();

  Future<DashboardModel> getDashboardData();

  Future<List<VehicleFeatureModel>> getVehicleAllFeatures();

  Future<List<VehicleTypeModel>> getVehicleAllTypes();

  Future<List<FuelTypeModel>> getAllFuelTypes();

  Future<List<VehicleModelModel>> getVehicleModels();

  Future<List<VehicleMakeModel>> getVehicleAllMakes();

  Future<List<ExpenseHeadModel>> getAllExpenseHeads();

  NetworkRepository get networkRepository => _networkRepository;
}
