part of 'bookings_by_customer_bloc.dart';

sealed class BookingsByCustomerEvent extends Equatable {
  const BookingsByCustomerEvent();
}

final class LoadBookingsByCustomerEvent extends BookingsByCustomerEvent {
  final String customerId;

  const LoadBookingsByCustomerEvent({required this.customerId});

  @override
  List<Object?> get props => [];
}
