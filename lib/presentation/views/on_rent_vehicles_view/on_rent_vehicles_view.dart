import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/booking/approved_bookings_bloc/approved_bookings_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/gradient_body.dart';
import '../../elements/vehicle_card_2.dart';

class OnRentVehiclesView extends StatelessWidget {
  const OnRentVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('On Rent Vehicles'),
      ),
      body: GradientBody(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              15.height,
              AppTextField(
                controller: TextEditingController(),
                textInputAction: TextInputAction.search,
                hintText: 'Search',
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  size: 22,
                ),
              ),
              10.height,
              Expanded(
                child: BlocBuilder<ApprovedBookingsBloc, ApprovedBookingsState>(
                  builder: (context, state) {
                    if (state is ApprovedBookingsError) {
                      return Center(
                          child: Text(
                        state.error,
                        style: TextStyle(color: context.colorScheme.onPrimary),
                      ));
                    } else if (state is ApprovedBookingsLoaded) {
                      return RefreshIndicator.adaptive(
                        onRefresh: () async => context
                            .read<ApprovedBookingsBloc>()
                            .add(LoadApprovedBookingsEvent()),
                        child: ListView.separated(
                          padding: EdgeInsets.only(bottom: 20),
                          separatorBuilder: (context, index) => 14.height,
                          itemCount: state.bookings.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              VehicleCard2(
                                status: 'Active',
                                showTrackLocationIcon: true,
                                showReturnVehicleIcon: true,
                                vehicle: state.bookings[index].vehicle!,
                                booking: state.bookings[index],
                              ),
                              12.height,
                              Material(
                                color: Colors.transparent,
                                child: ListTile(
                                  dense: true,
                                  leading: CircleAvatar(),
                                  tileColor: getIt<AppColors>().kCardColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      side: BorderSide(
                                          color: context.colorScheme.outline)),
                                  title: Text(
                                    state.bookings[index].customer?.name ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: context.colorScheme.onPrimary,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton.outlined(
                                              style: IconButton.styleFrom(
                                                fixedSize: Size(30, 30),
                                                iconSize: 16,
                                                backgroundColor:
                                                    context.colorScheme.surface,
                                                foregroundColor:
                                                    getIt<AppColors>()
                                                        .kPrimaryColor,
                                                padding: EdgeInsets.zero,
                                                side: BorderSide(
                                                  color: getIt<AppColors>()
                                                      .kPrimaryColor,
                                                ),
                                              ),
                                              onPressed: () async {
                                                final Uri callUri = Uri(
                                                  scheme: 'tel',
                                                  path: state
                                                          .bookings[index]
                                                          .customer
                                                          ?.mobileNumber ??
                                                      '',
                                                );
                                                if (!await launchUrl(callUri)) {
                                                  throw Exception(
                                                      'Could not launch $callUri');
                                                }
                                              },
                                              icon: Icon(CupertinoIcons.phone))
                                          .space(height: 30, width: 30),
                                      12.width,
                                      IconButton.outlined(
                                              style: IconButton.styleFrom(
                                                fixedSize: Size(30, 30),
                                                iconSize: 16,
                                                backgroundColor:
                                                    context.colorScheme.surface,
                                                foregroundColor:
                                                    getIt<AppColors>()
                                                        .kPrimaryColor,
                                                padding: EdgeInsets.zero,
                                                side: BorderSide(
                                                  color: getIt<AppColors>()
                                                      .kPrimaryColor,
                                                ),
                                              ),
                                              onPressed: () async {
                                                final Uri smsUri = Uri(
                                                  scheme: 'sms',
                                                  path: state
                                                          .bookings[index]
                                                          .customer
                                                          ?.mobileNumber ??
                                                      '',
                                                );
                                                if (!await launchUrl(smsUri)) {
                                                  throw Exception(
                                                      'Could not launch $smsUri');
                                                }
                                              },
                                              icon: Icon(
                                                  CupertinoIcons.bubble_right))
                                          .space(height: 30, width: 30),
                                    ],
                                  ),
                                  subtitle: Text(
                                    state.bookings[index].customer
                                            ?.mobileNumber ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: context.colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
