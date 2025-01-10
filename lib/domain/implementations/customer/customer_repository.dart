import '../../../data/models/customer/customer_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/repositories/customer/base_customer_repository.dart';

class CustomerRepository extends BaseCustomerRepository {
  CustomerRepository(
      {required super.backendConfigs,
      required super.networkRepository,
      required super.imageServices});

  @override
  Future<List<CustomerModel>> getAllCustomers() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.customer,
          ]));
      return ResponseModel<List<CustomerModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<CustomerModel>.from(
                    data!.map((e) => CustomerModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }
}
