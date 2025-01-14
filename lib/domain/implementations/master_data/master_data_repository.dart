import '../../../data/models/master_data/color_model.dart';
import '../../../data/models/master_data/dashboard_model.dart';
import '../../../data/models/master_data/expense_head_model.dart';
import '../../../data/models/master_data/fuel_type_model.dart';
import '../../../data/models/master_data/vehicle_feature_model.dart';
import '../../../data/models/master_data/vehicle_make_model.dart';
import '../../../data/models/master_data/vehicle_model_model.dart';
import '../../../data/models/master_data/vehicle_type_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/repositories/master_data/base_master_data_repository.dart';

class MasterDataRepository extends BaseMasterDataRepository {
  MasterDataRepository(
      {required super.backendConfigs, required super.networkRepository});

  @override
  Future<List<ColorModel>> getVehicleAllColors() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.vehicleAllColors
          ]));
      return ResponseModel<List<ColorModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<ColorModel>.from(
                    data!.map((e) => ColorModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DashboardModel> getDashboardData() async {
    try {
      final res = await super.networkRepository.get(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.dashboard,
                super.backendConfigs.dashboardAllData
              ],
            ),
          );
      return ResponseModel<DashboardModel>.fromJson(
            res,
            (data) => data == null ? null : DashboardModel.fromJson(data),
          ).data ??
          DashboardModel();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleFeatureModel>> getVehicleAllFeatures() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.vehicleAllFeatures
          ]));
      return ResponseModel<List<VehicleFeatureModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleFeatureModel>.from(
                    data!.map((e) => VehicleFeatureModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleMakeModel>> getVehicleAllMakes() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.vehicleAllMakes
          ]));
      return ResponseModel<List<VehicleMakeModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleMakeModel>.from(
                    data!.map((e) => VehicleMakeModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FuelTypeModel>> getAllFuelTypes() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.vehicleAllFuels
          ]));
      return ResponseModel<List<FuelTypeModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<FuelTypeModel>.from(
                    data!.map((e) => FuelTypeModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleTypeModel>> getVehicleAllTypes() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.vehicleAllTypes
          ]));
      return ResponseModel<List<VehicleTypeModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleTypeModel>.from(
                    data!.map((e) => VehicleTypeModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleModelModel>> getVehicleModels() async {
    try {
      final res = await super.networkRepository.get(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.vehicle,
                super.backendConfigs.vehicleAllModels
              ],
            ),
          );
      return ResponseModel<List<VehicleModelModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleModelModel>.from(
                    data!.map((e) => VehicleModelModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ExpenseHeadModel>> getAllExpenseHeads() async {
    try {
      final res = await super.networkRepository.get(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.expense,
                super.backendConfigs.allHeads
              ],
            ),
          );
      return ResponseModel<List<ExpenseHeadModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<ExpenseHeadModel>.from(
                    data!.map((e) => ExpenseHeadModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }
}
