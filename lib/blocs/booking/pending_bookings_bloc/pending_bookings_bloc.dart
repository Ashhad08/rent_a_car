import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/booking/booking_list_model.dart';
import '../../../domain/implementations/booking/booking_repository.dart';

part 'pending_bookings_event.dart';
part 'pending_bookings_state.dart';

class PendingBookingsBloc
    extends Bloc<PendingBookingsEvent, PendingBookingsState> {
  final BookingRepository _repository;

  PendingBookingsBloc(this._repository) : super(PendingBookingsLoading()) {
    on<LoadPendingBookingsEvent>(_onLoadPendingBookingsEvent);
  }

  Future<void> _onLoadPendingBookingsEvent(LoadPendingBookingsEvent event,
      Emitter<PendingBookingsState> emit) async {
    try {
      emit(PendingBookingsLoading());
      final bookings = await _repository.getPendingBookings();
      emit(PendingBookingsLoaded(bookings: bookings));
    } catch (e) {
      emit(PendingBookingsError(error: e.toString()));
    }
  }
}
