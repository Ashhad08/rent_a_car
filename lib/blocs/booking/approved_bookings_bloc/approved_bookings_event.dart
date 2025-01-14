part of 'approved_bookings_bloc.dart';

sealed class ApprovedBookingsEvent extends Equatable {
  const ApprovedBookingsEvent();
}

final class LoadApprovedBookingsEvent extends ApprovedBookingsEvent {
  @override
  List<Object?> get props => [];
}
