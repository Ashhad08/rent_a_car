part of 'approved_bookings_bloc.dart';

sealed class ApprovedBookingsState extends Equatable {
  const ApprovedBookingsState();
}

final class ApprovedBookingsLoading extends ApprovedBookingsState {
  @override
  List<Object> get props => [];
}

final class ApprovedBookingsLoaded extends ApprovedBookingsState {
  final List<BookingListModel> bookings;

  const ApprovedBookingsLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class ApprovedBookingsError extends ApprovedBookingsState {
  final String error;

  const ApprovedBookingsError({required this.error});

  @override
  List<Object> get props => [error];
}
