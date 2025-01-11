part of 'all_promotions_bloc.dart';

sealed class AllPromotionsState extends Equatable {
  const AllPromotionsState();
}

final class AllPromotionsLoading extends AllPromotionsState {
  @override
  List<Object> get props => [];
}

final class AllPromotionsLoaded extends AllPromotionsState {
  final List<PromotionInfo> _promos;

  List<PromotionInfo> get promos => _promos;

  const AllPromotionsLoaded({required List<PromotionInfo> promos})
      : _promos = promos;

  @override
  List<Object> get props => [_promos];
}

final class AllPromotionsError extends AllPromotionsState {
  final String _error;

  String get error => _error;

  const AllPromotionsError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
