part of 'expense_all_heads_bloc.dart';

sealed class ExpenseAllHeadsState extends Equatable {
  const ExpenseAllHeadsState();
}

final class ExpenseAllHeadsLoading extends ExpenseAllHeadsState {
  @override
  List<Object> get props => [];
}

final class ExpenseAllHeadsLoaded extends ExpenseAllHeadsState {
  final List<ExpenseHeadModel> heads;

  const ExpenseAllHeadsLoaded({required this.heads});

  @override
  List<Object> get props => [heads];
}

final class ExpenseAllHeadsError extends ExpenseAllHeadsState {
  final String _error;

  String get error => _error;

  const ExpenseAllHeadsError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
