part of 'all_payment_vouchers_bloc.dart';

sealed class AllPaymentVouchersEvent extends Equatable {
  const AllPaymentVouchersEvent();
}

final class LoadAllPaymentVouchersEvent extends AllPaymentVouchersEvent {
  @override
  List<Object> get props => [];
}
