part of 'bookings_by_customer_bloc.dart';

sealed class BookingsByCustomerState extends Equatable {
  const BookingsByCustomerState();
}

final class BookingsByCustomerLoading extends BookingsByCustomerState {
  @override
  List<Object> get props => [];
}

final class BookingsByCustomerLoaded extends BookingsByCustomerState {
  final List<BookingListModel> bookings;

  const BookingsByCustomerLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class BookingsByCustomerError extends BookingsByCustomerState {
  final String error;

  const BookingsByCustomerError({required this.error});

  @override
  List<Object> get props => [error];
}
