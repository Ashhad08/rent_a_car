import 'package:flutter/material.dart';

import '../../../data/models/master_data/fuel_type_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../data/repositories/vehicle/base_vehicle_repository.dart';

class VehicleRepository extends BaseVehicleRepository {
  VehicleRepository(
      {required super.backendConfigs,
      required super.networkRepository,
      required super.imageServices});

  @override
  Future<ResponseModel<VehicleModel>> createVehicle(
      VehicleModel vehicle) async {
    try {
      final urls = await Future.wait([
        super.imageServices.uploadImages(vehicle.images ?? []),
        super.imageServices.uploadImages(vehicle.documents ?? []),
      ]);
      vehicle = vehicle.copyWith(
        images: urls.first,
        documents: urls.last,
      );
      debugPrint(vehicle.toJson().toString());
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.vehicle,
                super.backendConfigs.addVehicle,
              ],
            ),
            data: vehicle.toJson(),
          );
      return ResponseModel<VehicleModel>.fromJson(
        res,
        (data) => VehicleModel.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel<VehicleModel>> updateVehicle(
      VehicleModel vehicle) async {
    try {
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.vehicle,
                super.backendConfigs.updateVehicle,
              ],
            ),
            data: vehicle.toJson(),
          );
      return ResponseModel<VehicleModel>.fromJson(
        res,
        (data) => VehicleModel.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel<FuelTypeModel>> updateFuelRate(
      FuelTypeModel fuelType) async {
    try {
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.vehicle,
                super.backendConfigs.vehicleUpdateFuel,
              ],
            ),
            data: fuelType.toJson(),
          );
      return ResponseModel<FuelTypeModel>.fromJson(
        res,
        (data) => FuelTypeModel.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleModel>> getAllVehicles() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
          ]));
      return ResponseModel<List<VehicleModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleModel>.from(
                    data!.map((e) => VehicleModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleModel>> getAllUnassignedVehicles() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.owner,
            super.backendConfigs.unassignedVehicles,
          ]));
      return ResponseModel<List<VehicleModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleModel>.from(
                    data!.map((e) => VehicleModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleModel>> getAvailableForRentVehicles() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.availableVehicle,
          ]));
      return ResponseModel<List<VehicleModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleModel>.from(
                    data!.map((e) => VehicleModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }
}
