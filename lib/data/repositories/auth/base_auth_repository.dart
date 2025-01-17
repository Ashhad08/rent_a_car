import '../../../configurations/backend_configs.dart';
import '../../../network/network_repository.dart';
import '../../models/response/response_model.dart';

abstract class BaseAuthRepository {
  final BackendConfigs _backendConfigs;

  BackendConfigs get backendConfigs => _backendConfigs;
  final NetworkRepository _networkRepository;

  BaseAuthRepository(
      {required BackendConfigs backendConfigs,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _networkRepository = networkRepository;

  NetworkRepository get networkRepository => _networkRepository;

  Future<ResponseModel> login(
      {required String email, required String password});
}
