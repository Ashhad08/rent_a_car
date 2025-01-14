part of 'expense_all_heads_bloc.dart';

sealed class ExpenseAllHeadsEvent extends Equatable {
  const ExpenseAllHeadsEvent();
}

final class LoadExpenseAllHeadsEvent extends ExpenseAllHeadsEvent {
  @override
  List<Object?> get props => [];
}
