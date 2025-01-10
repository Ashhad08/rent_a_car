part of 'all_customers_bloc.dart';

sealed class AllCustomersState extends Equatable {
  const AllCustomersState();
}

final class AllCustomersLoading extends AllCustomersState {
  @override
  List<Object> get props => [];
}

final class AllCustomersLoaded extends AllCustomersState {
  final List<CustomerModel> _customers;

  List<CustomerModel> get customers => _customers;

  const AllCustomersLoaded({required List<CustomerModel> customers})
      : _customers = customers;

  @override
  List<Object> get props => [_customers];
}

final class AllCustomersError extends AllCustomersState {
  final String _error;

  String get error => _error;

  const AllCustomersError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
