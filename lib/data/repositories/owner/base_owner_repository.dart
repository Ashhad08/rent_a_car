import '../../../configurations/backend_configs.dart';
import '../../../domain/services/image_services.dart';
import '../../../network/network_repository.dart';
import '../../models/owner/owner_model.dart';
import '../../models/response/response_model.dart';

abstract class BaseOwnerRepository {
  final BackendConfigs _backendConfigs;
  final ImageServices _imageServices;

  ImageServices get imageServices => _imageServices;

  BackendConfigs get backendConfigs => _backendConfigs;
  final NetworkRepository _networkRepository;

  BaseOwnerRepository(
      {required BackendConfigs backendConfigs,
      required ImageServices imageServices,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _imageServices = imageServices,
        _networkRepository = networkRepository;

  NetworkRepository get networkRepository => _networkRepository;

  Future<ResponseModel<OwnerInfo>> createOwner(OwnerInfo owner);

  Future<ResponseModel<OwnerInfo>> updateOwner(OwnerInfo owner);

  Future<List<OwnerModel>> getAllOwners();
}
