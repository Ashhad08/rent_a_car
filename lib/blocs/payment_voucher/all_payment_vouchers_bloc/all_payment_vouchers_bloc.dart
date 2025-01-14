import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/payment_voucher/payment_voucher_model.dart';
import '../../../domain/implementations/payment_voucher/payment_voucher_repository.dart';

part 'all_payment_vouchers_event.dart';
part 'all_payment_vouchers_state.dart';

class AllPaymentVouchersBloc
    extends Bloc<AllPaymentVouchersEvent, AllPaymentVouchersState> {
  final PaymentVoucherRepository _repository;

  AllPaymentVouchersBloc(this._repository)
      : super(AllPaymentVouchersLoading()) {
    on<LoadAllPaymentVouchersEvent>(_onLoadAllPaymentVouchersEvent);
  }

  Future<void> _onLoadAllPaymentVouchersEvent(LoadAllPaymentVouchersEvent event,
      Emitter<AllPaymentVouchersState> emit) async {
    try {
      emit(AllPaymentVouchersLoading());
      final paymentVouchers = await _repository.getAllPaymentVouchers();
      emit(AllPaymentVouchersLoaded(paymentVouchers: paymentVouchers));
    } catch (e) {
      emit(AllPaymentVouchersError(error: e.toString()));
    }
  }
}
