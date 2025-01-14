part of 'pending_bookings_bloc.dart';

sealed class PendingBookingsEvent extends Equatable {
  const PendingBookingsEvent();
}

final class LoadPendingBookingsEvent extends PendingBookingsEvent {
  @override
  List<Object?> get props => [];
}
