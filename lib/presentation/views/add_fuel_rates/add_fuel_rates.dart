import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../blocs/master_data/all_fuel_types_bloc/all_fuel_types_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_drop_down.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';

class AddFuelRates extends StatefulWidget {
  const AddFuelRates({super.key});

  @override
  State<AddFuelRates> createState() => _AddFuelRatesState();
}

class _AddFuelRatesState extends State<AddFuelRates> {
  MapEntry<String, String>? _selectedFuelType;
  final TextEditingController _rateController = TextEditingController();
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
              title: const Text('Add Fuel Rates'),
            ),
            body: BlocBuilder<AllFuelTypesBloc, AllFuelTypesState>(
              builder: (context, state) {
                if (state is AllFuelTypesError) {
                  return GradientBody(
                      child: Center(
                    child: Text(state.error,
                        style: TextStyle(color: context.colorScheme.onPrimary)),
                  ));
                } else if (state is AllFuelTypesLoaded) {
                  final fuelTypes = state.fuelTypes;
                  return GradientBody(
                    child: RefreshIndicator(
                      onRefresh: () async => context
                          .read<AllFuelTypesBloc>()
                          .add(LoadAllFuelTypesEvent()),
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: _key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: getIt<AppColors>().kCardColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: context.colorScheme.outline),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Fuel Type',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                context.colorScheme.onPrimary),
                                      ),
                                      8.height,
                                      CustomDropDown(
                                        errorMessageIfRequired:
                                            'Kindly Select Type',
                                        label: 'Select Type',
                                        dropdownMenuEntries: (fuelTypes.map(
                                          (e) => MapEntry(
                                              e.id ?? "", e.fuelName ?? ""),
                                        )).toList(),
                                        onSelected: (val) {
                                          if (val != null) {
                                            _selectedFuelType = val;
                                          }
                                        },
                                        enabled: true,
                                        initialItem: _selectedFuelType,
                                      ),
                                      8.height,
                                      AppTextField(
                                        controller: _rateController,
                                        textInputType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Kindly enter rate';
                                          } else if (val.isNotEmpty &&
                                              !val.isDecimalPositiveNumber) {
                                            return 'Kindly enter valid rate';
                                          }
                                          return null;
                                        },
                                        hintText: 'Enter Fuel Rate',
                                      ),
                                    ],
                                  ),
                                ),
                                20.height,
                                CustomElevatedButton(
                                  onPressed: () async {
                                    final utils = getIt<Utils>();
                                    if (_key.currentState!.validate() &&
                                        !context
                                            .read<LoadingBloc>()
                                            .state
                                            .isLoading) {
                                      final repo = getIt<VehicleRepository>();

                                      try {
                                        context
                                            .read<LoadingBloc>()
                                            .add(StartLoading());
                                        final fuelType = fuelTypes
                                            .where(
                                              (element) =>
                                                  element.id ==
                                                  _selectedFuelType?.key,
                                            )
                                            .first;
                                        final res = await repo
                                            .updateFuelRate(fuelType.copyWith(
                                          fuelRate: num.tryParse(
                                              _rateController.text.trim()),
                                        ));
                                        if (mounted && context.mounted) {
                                          context
                                              .read<LoadingBloc>()
                                              .add(StopLoading());
                                          context
                                              .read<AllFuelTypesBloc>()
                                              .add(LoadAllFuelTypesEvent());
                                          getIt<NavigationHelper>()
                                              .pop(context);
                                          utils.showSuccessFlushBar(context,
                                              message: res.message ??
                                                  "Fuel Rate Updated Successfully");
                                        }
                                      } catch (e, stackTrace) {
                                        if (context.mounted) {
                                          debugPrint(stackTrace.toString());
                                          context
                                              .read<LoadingBloc>()
                                              .add(StopLoading());
                                          utils.showErrorFlushBar(context,
                                              message: e.toString());
                                        }
                                      }
                                    }
                                  },
                                  text: 'Save Rates',
                                ),
                                18.height,
                                Text(
                                  'Current Rates',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: context.colorScheme.onPrimary),
                                ),
                                12.height,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 17),
                                  decoration: BoxDecoration(
                                    color: getIt<AppColors>().kCardColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: context.colorScheme.outline),
                                  ),
                                  child: Column(
                                    spacing: 20,
                                    children: fuelTypes
                                        .map(
                                          (e) => Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  e.fuelName ?? "",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: context.colorScheme
                                                          .onPrimary),
                                                ),
                                              ),
                                              10.width,
                                              Text(
                                                (e.fuelRate ?? 0).toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: context
                                                        .colorScheme.onPrimary),
                                              )
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return GradientBody(
                    child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ));
              },
            ),
          ),
        );
      }),
    );
  }
}
