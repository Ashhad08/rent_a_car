import '../../../data/models/promotion/promotion_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/repositories/promotion/base_promotion_repository.dart';

class PromotionRepository extends BasePromotionRepository {
  PromotionRepository(
      {required super.backendConfigs, required super.networkRepository});

  @override
  Future<ResponseModel<PromotionInfo>> createPromotion(
      PromotionInfo promo) async {
    try {
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.promotion,
                super.backendConfigs.addPromotion,
              ],
            ),
            data: promo.toJson(),
          );
      return ResponseModel<PromotionInfo>.fromJson(
        res,
        (data) => PromotionInfo.fromJson(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> deletePromotion(String promoId) async {
    try {
      final res = await super.networkRepository.post(
        uri: super.backendConfigs.buildUri(
          segments: [
            super.backendConfigs.promotion,
            super.backendConfigs.deletePromotion,
          ],
        ),
        data: {
          "promoID": promoId,
        },
      );
      return ResponseModel.fromJson(
        res,
        (data) => null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> updatePromotion(PromotionInfo promo) async {
    try {
      final res = await super.networkRepository.post(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.promotion,
                super.backendConfigs.updatePromotion,
              ],
            ),
            data: promo.toJson(),
          );
      return ResponseModel.fromJson(
        res,
        (data) => null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PromotionInfo>> getAllPromotions() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.promotion,
          ]));
      return ResponseModel<List<PromotionInfo>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<PromotionInfo>.from(
                    data!.map((e) => PromotionInfo.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }
}
