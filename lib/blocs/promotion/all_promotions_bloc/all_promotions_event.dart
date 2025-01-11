part of 'all_promotions_bloc.dart';

sealed class AllPromotionsEvent extends Equatable {
  const AllPromotionsEvent();
}

final class LoadAllPromotionsEvent extends AllPromotionsEvent {
  @override
  List<Object> get props => [];
}
