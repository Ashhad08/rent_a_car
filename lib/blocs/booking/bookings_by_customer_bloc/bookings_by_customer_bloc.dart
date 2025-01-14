import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/booking/booking_list_model.dart';
import '../../../domain/implementations/booking/booking_repository.dart';

part 'bookings_by_customer_event.dart';
part 'bookings_by_customer_state.dart';

class BookingsByCustomerBloc
    extends Bloc<BookingsByCustomerEvent, BookingsByCustomerState> {
  final BookingRepository _repository;

  BookingsByCustomerBloc(this._repository)
      : super(BookingsByCustomerLoading()) {
    on<LoadBookingsByCustomerEvent>(_onLoadBookingsByCustomerEvent);
  }

  Future<void> _onLoadBookingsByCustomerEvent(LoadBookingsByCustomerEvent event,
      Emitter<BookingsByCustomerState> emit) async {
    try {
      emit(BookingsByCustomerLoading());
      final bookings =
          await _repository.getBookingsByCustomer(event.customerId);
      emit(BookingsByCustomerLoaded(bookings: bookings));
    } catch (e) {
      emit(BookingsByCustomerError(error: e.toString()));
    }
  }
}
