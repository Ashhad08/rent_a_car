part of 'pending_bookings_bloc.dart';

sealed class PendingBookingsState extends Equatable {
  const PendingBookingsState();
}

final class PendingBookingsLoading extends PendingBookingsState {
  @override
  List<Object> get props => [];
}

final class PendingBookingsLoaded extends PendingBookingsState {
  final List<BookingListModel> bookings;

  const PendingBookingsLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class PendingBookingsError extends PendingBookingsState {
  final String error;

  const PendingBookingsError({required this.error});

  @override
  List<Object> get props => [error];
}
