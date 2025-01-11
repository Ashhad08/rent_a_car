import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/vehicle/available_for_rent_vehicles_bloc/available_for_rent_vehicles_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/gradient_body.dart';
import '../../elements/vehicle_card_2.dart';

class AvailableForRentVehiclesView extends StatelessWidget {
  const AvailableForRentVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Available For Rent'),
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
                child: BlocBuilder<AvailableForRentVehiclesBloc,
                    AvailableForRentVehiclesState>(
                  builder: (context, state) {
                    if (state is AvailableForRentVehiclesLoaded) {
                      return RefreshIndicator.adaptive(
                        onRefresh: () async =>
                            context.read<AvailableForRentVehiclesBloc>().add(
                                  LoadAvailableForRentVehiclesEvent(),
                                ),
                        child: ListView.separated(
                          padding: EdgeInsets.only(bottom: 20),
                          separatorBuilder: (context, index) => 14.height,
                          itemCount: state.vehicles.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) => VehicleCard2(
                            status: 'Available',
                            vehicle: state.vehicles[index],
                            statusIcon: CircleAvatar(
                                radius: 5,
                                backgroundColor:
                                    getIt<AppColors>().kPrimaryColor),
                          ),
                        ),
                      );
                    }
                    if (state is AvailableForRentVehiclesError) {
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
