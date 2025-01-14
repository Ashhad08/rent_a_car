import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/booking/approved_bookings_bloc/approved_bookings_bloc.dart';
import '../../../blocs/booking/pending_bookings_bloc/pending_bookings_bloc.dart';
import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../blocs/payment_voucher/all_payment_vouchers_bloc/all_payment_vouchers_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/booking/booking_list_model.dart';
import '../../../data/models/booking/make_update_booking_model.dart';
import '../../../data/models/payment_voucher/payment_voucher_model.dart';
import '../../../domain/implementations/payment_voucher/payment_voucher_repository.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';
import '../rental_requests_view/widgets/booking_card.dart';

class AddUpdatePaymentReceiptView extends StatefulWidget {
  const AddUpdatePaymentReceiptView({super.key, required this.booking});

  final BookingListModel booking;

  @override
  State<AddUpdatePaymentReceiptView> createState() =>
      _AddUpdatePaymentReceiptViewState();
}

class _AddUpdatePaymentReceiptViewState
    extends State<AddUpdatePaymentReceiptView> {
  int _days = 0;
  num _totalAmount = 0;
  num _discount = 0;
  num _dueAmount = 0;

  final TextEditingController _receivedAmountController =
      TextEditingController(text: '0');

  @override
  void dispose() {
    _receivedAmountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.booking.receiptVoucher == null) {
      _calculateAmount();
    } else {
      final startDate = widget.booking.fromDate;
      final endDate = widget.booking.toDate;
      if (endDate != null && startDate != null) {
        _days = endDate.difference(startDate).inDays;
      }
      _dueAmount = widget.booking.receiptVoucher?.dueAmount ?? 0;
    }
    super.initState();
  }

  _calculateAmount() {
    final startDate = widget.booking.fromDate;
    final endDate = widget.booking.toDate;
    final bool isWithOutDriver = !(widget.booking.withDriver ?? false);
    if (endDate != null && startDate != null) {
      _days = endDate.difference(startDate).inDays;
      if (_days > 0) {
        _totalAmount = _days *
            (int.tryParse(isWithOutDriver
                    ? widget.booking.vehicle?.rateWithoutDriver ?? ""
                    : widget.booking.vehicle?.rateWithDriver ?? "") ??
                0);
        if (_days >= 30) {
          _discount =
              (num.tryParse(widget.booking.vehicle?.discountMonth ?? "0")) ?? 0;
          _dueAmount = (_totalAmount * (_discount / 100)).toInt();
        } else if (_days >= 7) {
          _discount =
              (num.tryParse(widget.booking.vehicle?.discountWeek ?? "0")) ?? 0;
          _dueAmount = (_totalAmount * (_discount / 100)).toInt();
        }
      }
    }
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingBloc(),
      child: Builder(builder: (context) {
        return LoadingOverlay(
          isLoading: context.select((LoadingBloc bloc) => bloc.state.isLoading),
          progressIndicator: CircularProgressIndicator.adaptive(),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: getIt<Utils>().popIcon(context),
              title: Text(
                  '${widget.booking.receiptVoucher != null ? 'Edit' : 'Add'} Payment Receipt'),
            ),
            body: GradientBody(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BookingCard(
                          booking: widget.booking,
                          showActions: false,
                          showEditIcon: false,
                        ),
                        18.height,
                        Text(
                          'Total Days',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        8.height,
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: context.colorScheme.surface,
                            ),
                          ),
                          child: Text(
                            _days < 0 ? '' : _days.toString(),
                            style:
                                TextStyle(color: context.colorScheme.onPrimary),
                          ),
                        ),
                        16.height,
                        if (widget.booking.receiptVoucher == null) ...[
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                          8.height,
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: context.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: context.colorScheme.surface,
                                ),
                              ),
                              child: Text(
                                _totalAmount.toString(),
                                style: TextStyle(
                                    color: context.colorScheme.onPrimary),
                              )),
                          16.height,
                          Text(
                            'Discount Applied',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                          8.height,
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: context.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: context.colorScheme.surface,
                                ),
                              ),
                              child: Text(
                                "${_discount.toString()}%",
                                style: TextStyle(
                                    color: context.colorScheme.onPrimary),
                              )),
                          16.height,
                          Text(
                            'Due Amount',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                          8.height,
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: context.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: context.colorScheme.surface,
                                ),
                              ),
                              child: Text(
                                _dueAmount.toString(),
                                style: TextStyle(
                                    color: context.colorScheme.onPrimary),
                              )),
                        ] else ...[
                          Text(
                            'Due Amount',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                          8.height,
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: context.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: context.colorScheme.surface,
                                ),
                              ),
                              child: Text(
                                _dueAmount.toString(),
                                style: TextStyle(
                                    color: context.colorScheme.onPrimary),
                              )),
                          16.height,
                          Text(
                            'Already received Amount',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                          8.height,
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: context.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: context.colorScheme.surface,
                                ),
                              ),
                              child: Text(
                                (widget.booking.receiptVoucher
                                            ?.recievedAmount ??
                                        0)
                                    .toString(),
                                style: TextStyle(
                                    color: context.colorScheme.onPrimary),
                              ))
                        ],
                        16.height,
                        Text(
                          'Enter Received Amount',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary),
                        ),
                        10.height,
                        AppTextField(
                            controller: _receivedAmountController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Kindly Enter amount';
                              } else if (val.isNotEmpty &&
                                  !val.isDecimalPositiveNumber) {
                                return 'Kindly enter valid amount';
                              }
                              return null;
                            },
                            hintText: 'Enter Received Amount'),
                        18.height,
                        Text(
                          'Balance Amount',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary),
                        ),
                        10.height,
                        ListenableBuilder(
                            listenable: _receivedAmountController,
                            builder: (context, _) {
                              final amount = ((num.tryParse(
                                          _receivedAmountController.text
                                              .trim()) ??
                                      0) +
                                  (widget.booking.receiptVoucher
                                          ?.recievedAmount ??
                                      0));
                              final balance = _dueAmount - amount;
                              return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: context.colorScheme.surface,
                                    ),
                                  ),
                                  child: Text(
                                    balance.toString(),
                                    style: TextStyle(
                                        color: context.colorScheme.onPrimary),
                                  ));
                            }),
                        34.height,
                        if ((widget.booking.receiptVoucher?.recievedAmount ??
                                0) !=
                            _dueAmount)
                          CustomElevatedButton(
                            onPressed: () async {
                              final utils = getIt<Utils>();
                              final repo = getIt<PaymentVoucherRepository>();
                              final receivedAmount = num.tryParse(
                                      _receivedAmountController.text.trim()) ??
                                  0;

                              if (!_key.currentState!.validate() ||
                                  context.read<LoadingBloc>().state.isLoading) {
                                return;
                              }

                              if (receivedAmount <= 0) {
                                utils.showErrorFlushBar(context,
                                    message:
                                        'Please enter a valid received amount.');
                                return;
                              }

                              final balance = _dueAmount - receivedAmount;

                              if (widget.booking.receiptVoucher == null) {
                                if (receivedAmount > _dueAmount) {
                                  utils.showErrorFlushBar(context,
                                      message:
                                          'Received amount cannot exceed the due amount.');
                                  return;
                                }

                                final voucher = PaymentReceiptModel(
                                  discountApplied: _discount > 0,
                                  dueAmount: _dueAmount,
                                  recievedAmount: receivedAmount,
                                  balanceAmount: balance,
                                );

                                try {
                                  context
                                      .read<LoadingBloc>()
                                      .add(StartLoading());
                                  final res = await repo.createVoucher(
                                      voucher,
                                      widget.booking.vehicle!,
                                      MakeUpdateBookingModel(
                                        bookingId: widget.booking.id,
                                        returnDate: widget.booking.returnDate,
                                        returnCondition:
                                            widget.booking.returnCondition,
                                        vehicleLongitude:
                                            widget.booking.vehicleLongitude,
                                        vehicleLatitude:
                                            widget.booking.vehicleLatitude,
                                        toDate: widget.booking.toDate,
                                        fromDate: widget.booking.fromDate,
                                        status: widget.booking.status,
                                        customerId: widget.booking.customer?.id,
                                        vehicleId: widget.booking.vehicle?.id,
                                        withDriver: widget.booking.withDriver,
                                      ));
                                  if (mounted && context.mounted) {
                                    context
                                        .read<LoadingBloc>()
                                        .add(StopLoading());
                                    context
                                        .read<PendingBookingsBloc>()
                                        .add(LoadPendingBookingsEvent());
                                    getIt<NavigationHelper>().pop(context);
                                    utils.showSuccessFlushBar(context,
                                        message:
                                            res.message ?? "Voucher added");
                                  }
                                } catch (e, stackTrace) {
                                  if (context.mounted) {
                                    debugPrint(stackTrace.toString());
                                    debugPrint(e.toString());
                                    context
                                        .read<LoadingBloc>()
                                        .add(StopLoading());
                                    utils.showErrorFlushBar(context,
                                        message: e.toString());
                                  }
                                }
                              } else {
                                final previousReceivedAmount = widget.booking
                                        .receiptVoucher?.recievedAmount ??
                                    0;
                                final newTotalReceivedAmount =
                                    previousReceivedAmount + receivedAmount;

                                if (newTotalReceivedAmount > _dueAmount) {
                                  utils.showErrorFlushBar(context,
                                      message:
                                          'Received amount cannot exceed the due amount.');
                                  return;
                                }

                                final voucher =
                                    widget.booking.receiptVoucher!.copyWith(
                                  discountApplied: _discount > 0,
                                  dueAmount: _dueAmount,
                                  recievedAmount: newTotalReceivedAmount,
                                  balanceAmount:
                                      _dueAmount - newTotalReceivedAmount,
                                );
                                try {
                                  context
                                      .read<LoadingBloc>()
                                      .add(StartLoading());
                                  final res = await repo.updateVoucher(
                                      voucher, widget.booking.id.toString());
                                  if (mounted && context.mounted) {
                                    context
                                        .read<LoadingBloc>()
                                        .add(StopLoading());
                                    context
                                        .read<PendingBookingsBloc>()
                                        .add(LoadPendingBookingsEvent());
                                    context
                                        .read<ApprovedBookingsBloc>()
                                        .add(LoadApprovedBookingsEvent());
                                    context
                                        .read<AllPaymentVouchersBloc>()
                                        .add(LoadAllPaymentVouchersEvent());
                                    getIt<NavigationHelper>().pop(context);
                                    utils.showSuccessFlushBar(context,
                                        message:
                                            res.message ?? "Voucher updated");
                                  }
                                } catch (e, stackTrace) {
                                  if (context.mounted) {
                                    debugPrint(stackTrace.toString());
                                    debugPrint(e.toString());
                                    context
                                        .read<LoadingBloc>()
                                        .add(StopLoading());
                                    utils.showErrorFlushBar(context,
                                        message: e.toString());
                                  }
                                }
                              }
                            },
                            text: 'Save Voucher',
                          ),
                        20.height,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
