import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/promotion/promotion_model.dart';
import '../../../domain/implementations/promotion/promotion_repository.dart';

part 'all_promotions_event.dart';
part 'all_promotions_state.dart';

class AllPromotionsBloc extends Bloc<AllPromotionsEvent, AllPromotionsState> {
  final PromotionRepository _repository;

  AllPromotionsBloc(this._repository) : super(AllPromotionsLoading()) {
    on<LoadAllPromotionsEvent>(_onLoadAllPromotionsEvent);
  }

  Future<void> _onLoadAllPromotionsEvent(
      LoadAllPromotionsEvent event, Emitter<AllPromotionsState> emit) async {
    try {
      emit(AllPromotionsLoading());
      final promos = await _repository.getAllPromotions();
      emit(AllPromotionsLoaded(promos: promos));
    } catch (e) {
      emit(AllPromotionsError(error: e.toString()));
    }
  }
}
