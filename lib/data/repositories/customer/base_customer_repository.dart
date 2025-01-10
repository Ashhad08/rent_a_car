import '../../../configurations/backend_configs.dart';
import '../../../domain/services/image_services.dart';
import '../../../network/network_repository.dart';
import '../../models/customer/customer_model.dart';

abstract class BaseCustomerRepository {
  final BackendConfigs _backendConfigs;
  final ImageServices _imageServices;

  ImageServices get imageServices => _imageServices;

  BackendConfigs get backendConfigs => _backendConfigs;
  final NetworkRepository _networkRepository;

  BaseCustomerRepository(
      {required BackendConfigs backendConfigs,
      required ImageServices imageServices,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _imageServices = imageServices,
        _networkRepository = networkRepository;

  NetworkRepository get networkRepository => _networkRepository;

  Future<List<CustomerModel>> getAllCustomers();
}
