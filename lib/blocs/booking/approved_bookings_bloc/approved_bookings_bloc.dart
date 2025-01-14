import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/booking/booking_list_model.dart';
import '../../../domain/implementations/booking/booking_repository.dart';

part 'approved_bookings_event.dart';
part 'approved_bookings_state.dart';

class ApprovedBookingsBloc
    extends Bloc<ApprovedBookingsEvent, ApprovedBookingsState> {
  final BookingRepository _repository;

  ApprovedBookingsBloc(this._repository) : super(ApprovedBookingsLoading()) {
    on<LoadApprovedBookingsEvent>(_onLoadApprovedBookingsEvent);
  }

  Future<void> _onLoadApprovedBookingsEvent(LoadApprovedBookingsEvent event,
      Emitter<ApprovedBookingsState> emit) async {
    try {
      emit(ApprovedBookingsLoading());
      final bookings = await _repository.getApprovedBookings();
      emit(ApprovedBookingsLoaded(bookings: bookings));
    } catch (e) {
      emit(ApprovedBookingsError(error: e.toString()));
    }
  }
}
