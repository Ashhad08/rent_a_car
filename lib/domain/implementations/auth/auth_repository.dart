import '../../../data/models/response/response_model.dart';
import '../../../data/repositories/auth/base_auth_repository.dart';
import '../../services/session_manager.dart';

class AuthRepository extends BaseAuthRepository {
  AuthRepository(
      {required super.backendConfigs, required super.networkRepository});

  @override
  Future<ResponseModel> login(
      {required String email, required String password}) async {
    try {
      if (email == 'admin@gmail.com' && password == '123') {
        await SessionManager().setLoggedIn(true);
        return ResponseModel(
          message: 'LoggedIn Successfully',
          status: 'success',
        );
      } else {
        throw 'Invalid email password';
      }
      // final res = await super.networkRepository.post(
      //   uri: super.backendConfigs.buildUri(
      //     segments: [
      //       super.backendConfigs.vehicle,
      //       super.backendConfigs.vehicleUpdateFuel,
      //     ],
      //   ),
      //   data: fuelType.toJson(),
      // );
      // return ResponseModel<FuelTypeModel>.fromJson(
      //   res,
      //       (data) => FuelTypeModel.fromJson(data),
      // );
    } catch (e) {
      rethrow;
    }
  }
}
