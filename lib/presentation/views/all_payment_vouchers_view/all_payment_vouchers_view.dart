import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/payment_voucher/all_payment_vouchers_bloc/all_payment_vouchers_bloc.dart';
import '../../../constants/extensions.dart';
import '../../elements/gradient_body.dart';
import '../rental_requests_view/widgets/booking_card.dart';

class AllPaymentVouchersView extends StatelessWidget {
  const AllPaymentVouchersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Receipt Vouchers'),
      ),
      body: GradientBody(
        child: BlocBuilder<AllPaymentVouchersBloc, AllPaymentVouchersState>(
          builder: (context, state) {
            if (state is AllPaymentVouchersLoaded) {
              final paymentVouchers = state.paymentVouchers
                  .where(
                    (element) => element.booking != null,
                  )
                  .toList();
              return RefreshIndicator.adaptive(
                onRefresh: () async =>
                    context.read<AllPaymentVouchersBloc>().add(
                          LoadAllPaymentVouchersEvent(),
                        ),
                child: ListView.separated(
                  padding: EdgeInsets.all(20),
                  separatorBuilder: (context, index) => 14.height,
                  itemCount: paymentVouchers.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return paymentVouchers[index].booking != null
                        ? BookingCard(
                            showEditIcon: true,
                            booking: paymentVouchers[index].booking!,
                            showActions: false)
                        : null;
                  },
                ),
              );
            }
            if (state is AllPaymentVouchersError) {
              return Center(
                child: Text(state.error,
                    style: TextStyle(color: context.colorScheme.onPrimary)),
              );
            }

            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }
}
