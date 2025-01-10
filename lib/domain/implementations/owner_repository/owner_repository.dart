import '../../../data/models/owner/owner_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/repositories/owner/base_owner_repository.dart';

class OwnerRepository extends BaseOwnerRepository {
  OwnerRepository(
      {required super.backendConfigs,
      required super.networkRepository,
      required super.imageServices});

  @override
  Future<ResponseModel<OwnerInfo>> createOwner(OwnerInfo owner) async {
    try {
      final url =
          await super.imageServices.uploadImages([owner.ownerImage ?? ""]);
      owner = owner.copyWith(
        ownerImage: url.first,
      );
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.owner,
                super.backendConfigs.addOwner,
              ],
            ),
            data: owner.toJson(),
          );
      return ResponseModel<OwnerInfo>.fromJson(
        res,
        (data) => OwnerInfo.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel<OwnerInfo>> updateOwner(OwnerInfo owner) async {
    try {
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.owner,
                super.backendConfigs.editOwner,
              ],
            ),
            data: owner.toJson(),
          );
      return ResponseModel<OwnerInfo>.fromJson(
        res,
        (data) => OwnerInfo.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<OwnerModel>> getAllOwners() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.owner,
          ]));
      return ResponseModel<List<OwnerModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<OwnerModel>.from(
                    data!.map((e) => OwnerModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }
}
