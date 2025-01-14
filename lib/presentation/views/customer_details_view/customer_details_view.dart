import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/booking/bookings_by_customer_bloc/bookings_by_customer_bloc.dart';
import '../../../blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import '../../../blocs/master_data/vehicle_models_bloc/vehicle_models_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/customer/customer_model.dart';
import '../../../domain/implementations/booking/booking_repository.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';

class CustomerDetailsView extends StatelessWidget {
  const CustomerDetailsView({super.key, required this.customer});

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingsByCustomerBloc(getIt<BookingRepository>())
        ..add(LoadBookingsByCustomerEvent(customerId: customer.id.toString())),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: getIt<Utils>().popIcon(context),
          title: const Text('Customer Details'),
        ),
        body: GradientBody(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DefaultTextStyle(
              style: TextStyle(color: context.colorScheme.onPrimary),
              child: Column(
                children: [
                  15.height,
                  Material(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: CircleAvatar(),
                      style: ListTileStyle.list,
                      tileColor: getIt<AppColors>().kCardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(color: context.colorScheme.outline)),
                      title: Text(
                        customer.name ?? "",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimary),
                      ),
                      subtitle: Text(
                        customer.mobileNumber ?? "",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onPrimary),
                      ),
                    ),
                  ),
                  18.height,
                  Expanded(child: BlocBuilder<BookingsByCustomerBloc,
                      BookingsByCustomerState>(
                    builder: (context, state) {
                      if (state is BookingsByCustomerLoaded) {
                        return RefreshIndicator.adaptive(
                          onRefresh: () async =>
                              context.read<BookingsByCustomerBloc>().add(
                                    LoadBookingsByCustomerEvent(
                                        customerId: customer.id.toString()),
                                  ),
                          child: ListView.separated(
                            padding: EdgeInsets.only(bottom: 20),
                            separatorBuilder: (context, index) => 18.height,
                            itemCount: state.bookings.length,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final booking = state.bookings[index];
                              final stateMake =
                                  context.read<VehicleAllMakesBloc>().state;
                              final stateModels =
                                  context.read<VehicleModelsBloc>().state;
                              String vehicleMake = '';
                              String vehicleModel = '';
                              if (stateMake is VehicleAllMakesLoaded) {
                                vehicleMake = stateMake.allMakes
                                        .where(
                                          (element) =>
                                              element.makeName?.toLowerCase() ==
                                              booking.vehicle?.makeName
                                                  ?.toLowerCase(),
                                        )
                                        .firstOrNull
                                        ?.makeName ??
                                    "";
                              }
                              if (stateModels is VehicleModelsLoaded) {
                                vehicleModel = stateModels.models
                                        .where(
                                          (element) =>
                                              element.id ==
                                              booking.vehicle?.carModelId,
                                        )
                                        .firstOrNull
                                        ?.modelName ??
                                    "";
                              }

                              final data = {
                                'carName': '$vehicleMake $vehicleModel',
                                'regNumber':
                                    'Reg: ${booking.vehicle?.regNo ?? ""}',
                                'fromDate': booking.fromDate != null
                                    ? DateFormat('MMM dd, yyyy')
                                        .format(booking.fromDate!)
                                    : '',
                                'toDate': booking.toDate != null
                                    ? DateFormat('MMM dd, yyyy')
                                        .format(booking.toDate!)
                                    : '',
                                'returnDate': booking.returnDate != null
                                    ? DateFormat('MMM dd, yyyy')
                                        .format(booking.returnDate!)
                                    : "",
                                'amountPaid':
                                    booking.receiptVoucher?.recievedAmount ==
                                        booking.receiptVoucher?.dueAmount,
                                'amount': (booking.receiptVoucher?.dueAmount
                                        ?.toString()) ??
                                    "",
                                'status': booking.status?.capitalizeFirst ?? "",
                              };
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: getIt<AppColors>().kCardColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: context.colorScheme.outline,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data['carName'] as String,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: context
                                                            .colorScheme
                                                            .onPrimary,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  6.height,
                                                  Text(
                                                    data['regNumber'] as String,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: context
                                                            .colorScheme
                                                            .onPrimary,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 14, vertical: 6),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    context.colorScheme.surface,
                                                border: Border.all(
                                                  color: getIt<AppColors>()
                                                      .kPrimaryColor,
                                                ),
                                              ),
                                              child: Text(
                                                data['status'] as String,
                                                style: TextStyle(
                                                    color: getIt<AppColors>()
                                                        .kPrimaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            )
                                          ],
                                        ),
                                        12.height,
                                        Text(
                                          'From Date',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        6.height,
                                        Text(
                                          data['fromDate'] as String,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        12.height,
                                        Text(
                                          'To Date',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        6.height,
                                        Text(
                                          data['toDate'] as String,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        12.height,
                                        Text(
                                          'Return Date',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        6.height,
                                        Text(
                                          (data['returnDate'] as String?) ?? "",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        12.height,
                                        Text(
                                          'Amount',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        6.height,
                                        Text(
                                          (data['amountPaid'] as bool)
                                              ? 'Paid'
                                              : 'Unpaid',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  12.height,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: getIt<AppColors>().kCardColor,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: context.colorScheme.outline,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Amount',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          data['amount'] as String,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        );
                      }
                      if (state is BookingsByCustomerError) {
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
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
