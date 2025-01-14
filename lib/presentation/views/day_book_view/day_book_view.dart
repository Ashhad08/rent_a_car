import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/expense/all_expenses_bloc/all_expenses_bloc.dart';
import '../../../blocs/payment_voucher/all_payment_vouchers_bloc/all_payment_vouchers_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';
import '../all_expenses_view/widgets/expense_card.dart';
import '../rental_requests_view/widgets/booking_card.dart';

class DayBookView extends StatefulWidget {
  const DayBookView({super.key});

  @override
  State<DayBookView> createState() => _DayBookViewState();
}

class _DayBookViewState extends State<DayBookView> {
  final _selectedTab = ValueNotifier<int>(0);

  @override
  void dispose() {
    _selectedTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'Expenses',
      'Receipts',
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Day Book'),
      ),
      body: GradientBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ValueListenableBuilder(
                  valueListenable: _selectedTab,
                  builder: (context, tabIndex, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        spacing: 8,
                        children: List.generate(
                          tabs.length,
                          (index) => OutlinedButton(
                            onPressed: () {
                              _selectedTab.value = index;
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: index == tabIndex
                                    ? getIt<AppColors>().kPrimaryColor
                                    : context.colorScheme.surface,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                side: BorderSide(
                                    color: index == tabIndex
                                        ? Colors.transparent
                                        : getIt<AppColors>().kPrimaryColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24))),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                  fontSize: 12,
                                  color: index == tabIndex
                                      ? context.colorScheme.surface
                                      : getIt<AppColors>().kPrimaryColor,
                                  fontWeight: index == tabIndex
                                      ? FontWeight.w500
                                      : FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: _selectedTab,
              builder: (context, tab, child) {
                if (tab == 0) {
                  return BlocBuilder<AllExpensesBloc, AllExpensesState>(
                    builder: (context, state) {
                      if (state is AllExpensesLoaded) {
                        return RefreshIndicator.adaptive(
                            onRefresh: () async =>
                                context.read<AllExpensesBloc>().add(
                                      LoadAllExpensesEvent(),
                                    ),
                            child: ListView.separated(
                              padding: EdgeInsets.all(20),
                              separatorBuilder: (context, index) => 14.height,
                              itemCount: state.expenses.length,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) => ExpenseCard(
                                  expense: state.expenses[index],
                                  showIcons: false),
                            ));
                      }
                      if (state is AllExpensesError) {
                        return Center(
                          child: Text(state.error,
                              style: TextStyle(
                                  color: context.colorScheme.onPrimary)),
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  );
                } else {
                  return BlocBuilder<AllPaymentVouchersBloc,
                      AllPaymentVouchersState>(
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
                                      showEditIcon: false,
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
                              style: TextStyle(
                                  color: context.colorScheme.onPrimary)),
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
