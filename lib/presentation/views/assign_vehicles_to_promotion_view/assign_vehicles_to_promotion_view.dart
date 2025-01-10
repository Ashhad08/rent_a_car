import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/vehicle/all_vehicles_bloc/all_vehicles_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';
import '../../elements/vehicle_card_2.dart';

class AssignVehiclesToPromotionView extends StatefulWidget {
  const AssignVehiclesToPromotionView({
    super.key,
    required this.assignedVehicles,
  });

  final List<VehicleModel> assignedVehicles;

  @override
  State<AssignVehiclesToPromotionView> createState() =>
      _AssignVehiclesToPromotionViewState();
}

class _AssignVehiclesToPromotionViewState extends State<AssignVehiclesToPromotionView> {
  late ValueNotifier<List<String>> _selectedVehicles;

  @override
  void initState() {
    _selectedVehicles = ValueNotifier<List<String>>(
        widget.assignedVehicles.map((e) => e.id ?? "").toList());
    super.initState();
  }

  @override
  void dispose() {
    _selectedVehicles.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('Select Vehicles'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: CustomElevatedButton(
                onPressed: () async {
                  final bloc = context.read<AllVehiclesBloc>();
                  if (bloc.state is AllVehiclesLoaded) {
                    final vehicles = (bloc.state as AllVehiclesLoaded)
                        .vehicles
                        .where((element) =>
                            _selectedVehicles.value.contains(element.id ?? ""))
                        .toList();
                    Navigator.pop(context, vehicles);
                  }
                },
                text: 'Assign')
            .space(height: 54),
      ),
      body: BlocBuilder<AllVehiclesBloc, AllVehiclesState>(
        builder: (context, state) {
          return GradientBody(
            child: Column(
              children: [
                Padding(
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
                      if (state is AllVehiclesLoaded)
                        ValueListenableBuilder(
                            valueListenable: _selectedVehicles,
                            builder: (context, selectedVehicles, child) {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: _selectedVehicles.value
                                            .toSet()
                                            .length ==
                                        state.vehicles
                                            .map((e) => e.id ?? "")
                                            .toSet()
                                            .length,
                                    onChanged: (value) {
                                      if (value!) {
                                        _selectedVehicles.value = state.vehicles
                                            .map((e) => e.id!)
                                            .toList();
                                      } else {
                                        _selectedVehicles.value = [];
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                  Text(
                                    'Select All',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              );
                            }),
                      10.height,
                    ],
                  ),
                ),
                body(
                  state,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget body(
    AllVehiclesState state,
  ) {
    if (state is AllVehiclesError) {
      return Expanded(
        child: Center(
          child: Text(state.error),
        ),
      );
    } else if (state is AllVehiclesLoaded) {
      final allVehicles = state.vehicles;
      return Expanded(
        child: RefreshIndicator(
          onRefresh: () async => context.read<AllVehiclesBloc>().add(
                LoadAllVehiclesEvent(),
              ),
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: 20, right: 20),
            separatorBuilder: (context, index) => 14.height,
            itemCount: allVehicles.length,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: _selectedVehicles,
                    builder: (context, selectedVehicles, child) {
                      return Checkbox(
                        value: selectedVehicles
                            .contains(allVehicles[index].id ?? ""),
                        onChanged: (value) {
                          final updatedList =
                              List<String>.from(selectedVehicles);
                          if (updatedList
                              .contains(allVehicles[index].id ?? "")) {
                            updatedList.remove(allVehicles[index].id ?? "");
                          } else {
                            updatedList.add(allVehicles[index].id ?? "");
                          }
                          _selectedVehicles.value = updatedList;
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      );
                    }),
                Expanded(
                  child: VehicleCard2(
                      status: _selectedVehicles.value
                              .contains(allVehicles[index].id ?? "")
                          ? 'Assigned'
                          : "Available",
                      vehicle: allVehicles[index],
                      statusIcon: CircleAvatar(
                          radius: 5, backgroundColor: Color(0xff06A623)),
                      statusColor: Color(0xff06A623)),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
  }
}
