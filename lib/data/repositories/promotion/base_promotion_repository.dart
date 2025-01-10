import '../../../configurations/backend_configs.dart';
import '../../../network/network_repository.dart';
import '../../models/promotion/promotion_model.dart';
import '../../models/response/response_model.dart';

abstract class BasePromotionRepository {
  final BackendConfigs _backendConfigs;

  BackendConfigs get backendConfigs => _backendConfigs;
  final NetworkRepository _networkRepository;

  BasePromotionRepository(
      {required BackendConfigs backendConfigs,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _networkRepository = networkRepository;

  NetworkRepository get networkRepository => _networkRepository;

  Future<ResponseModel<PromotionInfo>> createPromotion(PromotionInfo promo);

  Future<ResponseModel> updatePromotion(PromotionInfo promo);

  Future<List<PromotionInfo>> getAllPromotions();

  Future<ResponseModel> deletePromotion(String promoId);
}
