import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/master_data/expense_head_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';

part 'expense_all_heads_event.dart';
part 'expense_all_heads_state.dart';

class ExpenseAllHeadsBloc
    extends Bloc<ExpenseAllHeadsEvent, ExpenseAllHeadsState> {
  final MasterDataRepository _masterDataRepository;

  ExpenseAllHeadsBloc(this._masterDataRepository)
      : super(ExpenseAllHeadsLoading()) {
    on<LoadExpenseAllHeadsEvent>(_onLoadExpenseAllHeadsEvent);
  }

  Future<void> _onLoadExpenseAllHeadsEvent(LoadExpenseAllHeadsEvent event,
      Emitter<ExpenseAllHeadsState> emit) async {
    try {
      emit(ExpenseAllHeadsLoading());
      final response = await _masterDataRepository.getAllExpenseHeads();
      emit(ExpenseAllHeadsLoaded(heads: response));
    } catch (e) {
      emit(ExpenseAllHeadsError(error: e.toString()));
    }
  }
}
