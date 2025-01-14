part of 'all_payment_vouchers_bloc.dart';

sealed class AllPaymentVouchersState extends Equatable {
  const AllPaymentVouchersState();
}

final class AllPaymentVouchersLoading extends AllPaymentVouchersState {
  @override
  List<Object> get props => [];
}

final class AllPaymentVouchersLoaded extends AllPaymentVouchersState {
  final List<PaymentReceiptModel> paymentVouchers;

  const AllPaymentVouchersLoaded({required this.paymentVouchers});

  @override
  List<Object> get props => [paymentVouchers];
}

final class AllPaymentVouchersError extends AllPaymentVouchersState {
  final String _error;

  String get error => _error;

  const AllPaymentVouchersError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
