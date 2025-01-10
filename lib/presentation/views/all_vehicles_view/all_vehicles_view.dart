import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/vehicle/all_vehicles_bloc/all_vehicles_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/gradient_body.dart';
import 'widgets/vehicle_card.dart';

class AllVehiclesView extends StatelessWidget {
  const AllVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('All Vehicles'),
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
                child: BlocBuilder<AllVehiclesBloc, AllVehiclesState>(
                  builder: (context, state) {
                    if (state is AllVehiclesLoaded) {
                      return RefreshIndicator.adaptive(
                        onRefresh: () async =>
                            context.read<AllVehiclesBloc>().add(
                                  LoadAllVehiclesEvent(),
                                ),
                        child: ListView.separated(
                          padding: EdgeInsets.only(bottom: 20),
                          separatorBuilder: (context, index) => 14.height,
                          itemCount: state.vehicles.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) => VehicleCard(
                            vehicle: state.vehicles[index],
                          ),
                        ),
                      );
                    }
                    if (state is AllVehiclesError) {
                      return Center(
                        child: Text(state.error),
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
