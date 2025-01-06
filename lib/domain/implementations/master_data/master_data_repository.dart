import '../../../data/models/master_data/color_model.dart';
import '../../../data/models/master_data/vehicle_feature_model.dart';
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
          uri: super
              .backendConfigs
              .buildUri(segments: [super.backendConfigs.vehicleAllColors]));
      return ResponseModel<List<ColorModel>>.fromJson(res, ColorModel.fromJson)
              .data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleFeatureModel>> getVehicleAllFeatures() async {
    try {
      final res = await super.networkRepository.get(
          uri: super
              .backendConfigs
              .buildUri(segments: [super.backendConfigs.vehicleAllFeatures]));
      return ResponseModel<List<VehicleFeatureModel>>.fromJson(
                  res, VehicleFeatureModel.fromJson)
              .data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleTypeModel>> getVehicleAllTypes() async {
    try {
      final res = await super.networkRepository.get(
          uri: super
              .backendConfigs
              .buildUri(segments: [super.backendConfigs.vehicleAllTypes]));
      return ResponseModel<List<VehicleTypeModel>>.fromJson(
                  res, VehicleTypeModel.fromJson)
              .data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleModelModel>> getVehicleModelsForVehicleType(
      {required String vehicleTypeId}) async {
    try {
      final res = await super.networkRepository.post(
          uri: super.backendConfigs.buildUri(
            segments: [super.backendConfigs.vehicleAllModels],
          ),
          data: {"carTypeID": vehicleTypeId});
      return ResponseModel<List<VehicleModelModel>>.fromJson(
                  res, VehicleModelModel.fromJson)
              .data ??
          [];
    } catch (e) {
      rethrow;
    }
  }
}
