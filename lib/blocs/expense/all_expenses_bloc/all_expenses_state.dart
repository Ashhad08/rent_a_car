part of 'all_expenses_bloc.dart';

sealed class AllExpensesState extends Equatable {
  const AllExpensesState();
}

final class AllExpensesLoading extends AllExpensesState {
  @override
  List<Object> get props => [];
}

final class AllExpensesLoaded extends AllExpensesState {
  final List<ExpenseModel> _expenses;

  List<ExpenseModel> get expenses => _expenses;

  const AllExpensesLoaded({required List<ExpenseModel> expenses})
      : _expenses = expenses;

  @override
  List<Object> get props => [_expenses];
}

final class AllExpensesError extends AllExpensesState {
  final String _error;

  String get error => _error;

  const AllExpensesError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
