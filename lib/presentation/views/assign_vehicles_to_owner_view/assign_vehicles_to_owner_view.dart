import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../blocs/owner/all_owners/all_owners_bloc.dart';
import '../../../blocs/vehicle/all_unassigned_vehicles_bloc/all_unassigned_vehicles_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/owner/owner_model.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/owner_repository/owner_repository.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';
import '../../elements/vehicle_card_2.dart';

class AssignVehiclesToOwnerView extends StatefulWidget {
  const AssignVehiclesToOwnerView(
      {super.key, required this.assignedVehicles, required this.owner});

  final List<VehicleModel> assignedVehicles;
  final OwnerInfo owner;

  @override
  State<AssignVehiclesToOwnerView> createState() =>
      _AssignVehiclesToOwnerViewState();
}

class _AssignVehiclesToOwnerViewState extends State<AssignVehiclesToOwnerView> {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AllUnassignedVehiclesBloc(getIt<VehicleRepository>())
                ..add(LoadAllUnassignedVehiclesEvent()),
        ),
        BlocProvider(
          create: (context) => LoadingBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return LoadingOverlay(
          isLoading: context.select((LoadingBloc bloc) => bloc.state.isLoading),
          progressIndicator: CircularProgressIndicator.adaptive(),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: getIt<Utils>().popIcon(context),
              title: const Text('Select Vehicles'),
            ),
            bottomNavigationBar: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: CustomElevatedButton(
                      onPressed: () async {
                        final repo = getIt<OwnerRepository>();
                        final utils = getIt<Utils>();
                        try {
                          context.read<LoadingBloc>().add(StartLoading());
                          final res =
                              await repo.updateOwner(widget.owner.copyWith(
                            vehicles: _selectedVehicles.value.toSet().toList(),
                          ));
                          if (mounted && context.mounted) {
                            context.read<LoadingBloc>().add(StopLoading());
                            getIt<NavigationHelper>().pop(context);
                            getIt<NavigationHelper>().pop(context);
                            utils.showSuccessFlushBar(context,
                                message: res.message ??
                                    "Information updated successfully");
                            context
                                .read<AllOwnersBloc>()
                                .add(LoadAllOwnersEvent());
                          }
                        } catch (e, stackTrace) {
                          if (context.mounted) {
                            debugPrint(stackTrace.toString());
                            context.read<LoadingBloc>().add(StopLoading());
                            utils.showErrorFlushBar(context,
                                message: e.toString());
                          }
                        }
                      },
                      text: 'Assign')
                  .space(height: 54),
            ),
            body: BlocBuilder<AllUnassignedVehiclesBloc,
                AllUnassignedVehiclesState>(
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
                            if (state is AllUnassignedVehiclesLoaded)
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
                                              _selectedVehicles.value = state
                                                  .vehicles
                                                  .map((e) => e.id!)
                                                  .toList();
                                            } else {
                                              _selectedVehicles.value = [];
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                        ),
                                        Text(
                                          'Select All',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: context
                                                  .colorScheme.onPrimary),
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
          ),
        );
      }),
    );
  }

  Widget body(
    AllUnassignedVehiclesState state,
  ) {
    if (state is AllUnassignedVehiclesError) {
      return Expanded(
        child: Center(
          child: Text(state.error,
              style: TextStyle(color: context.colorScheme.onPrimary)),
        ),
      );
    } else if (state is AllUnassignedVehiclesLoaded) {
      final allVehicles = [...widget.assignedVehicles, ...state.vehicles];
      return Expanded(
        child: RefreshIndicator(
          onRefresh: () async => context.read<AllUnassignedVehiclesBloc>().add(
                LoadAllUnassignedVehiclesEvent(),
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
                        radius: 5,
                        backgroundColor: getIt<AppColors>().kPrimaryColor),
                  ),
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
