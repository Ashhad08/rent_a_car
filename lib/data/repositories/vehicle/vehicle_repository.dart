import '../../models/vehicle/vehicle.dart';

abstract class BaseVehicleRepository {
  Future<List<Vehicle>> getAllVehicles();
}
