import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/expense/expense_model.dart';
import '../../../domain/implementations/expense/expense_repository.dart';

part 'all_expenses_event.dart';
part 'all_expenses_state.dart';

class AllExpensesBloc extends Bloc<AllExpensesEvent, AllExpensesState> {
  final ExpenseRepository _repository;

  AllExpensesBloc(this._repository) : super(AllExpensesLoading()) {
    on<LoadAllExpensesEvent>(_onLoadAllExpensesEvent);
  }

  Future<void> _onLoadAllExpensesEvent(
      LoadAllExpensesEvent event, Emitter<AllExpensesState> emit) async {
    try {
      emit(AllExpensesLoading());
      final expenses = await _repository.getAllExpenses();
      emit(AllExpensesLoaded(expenses: expenses));
    } catch (e) {
      emit(AllExpensesError(error: e.toString()));
    }
  }
}
