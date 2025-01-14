part of 'all_expenses_bloc.dart';

sealed class AllExpensesEvent extends Equatable {
  const AllExpensesEvent();
}

final class LoadAllExpensesEvent extends AllExpensesEvent {
  @override
  List<Object> get props => [];
}
