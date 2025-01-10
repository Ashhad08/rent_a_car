part of 'all_customers_bloc.dart';

sealed class AllCustomersEvent extends Equatable {
  const AllCustomersEvent();
}

final class LoadAllCustomersEvent extends AllCustomersEvent {
  @override
  List<Object> get props => [];
}
