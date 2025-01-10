import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/customer/customer_model.dart';
import '../../../domain/implementations/customer/customer_repository.dart';

part 'all_customers_event.dart';
part 'all_customers_state.dart';

class AllCustomersBloc extends Bloc<AllCustomersEvent, AllCustomersState> {
  final CustomerRepository _repository;

  AllCustomersBloc(this._repository) : super(AllCustomersLoading()) {
    on<LoadAllCustomersEvent>(_onLoadAllCustomersEvent);
  }

  Future<void> _onLoadAllCustomersEvent(
      LoadAllCustomersEvent event, Emitter<AllCustomersState> emit) async {
    try {
      emit(AllCustomersLoading());
      final customers = await _repository.getAllCustomers();
      emit(AllCustomersLoaded(customers: customers));
    } catch (e) {
      emit(AllCustomersError(error: e.toString()));
    }
  }
}
