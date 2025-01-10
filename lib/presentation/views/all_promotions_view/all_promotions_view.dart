import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import '../../../blocs/promotion/all_promotions_bloc/all_promotions_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/promotion/promotion_model.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/master_data/master_data_repository.dart';
import '../../../domain/implementations/promotion/promotion_repository.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';
import '../add_update_promotions_view/add_update_promotions_view.dart';

class AllPromotionsView extends StatefulWidget {
  const AllPromotionsView({super.key});

  @override
  State<AllPromotionsView> createState() => _AllPromotionsViewState();
}

class _AllPromotionsViewState extends State<AllPromotionsView> {
  final _selectedTab = ValueNotifier<int>(0);

  @override
  void dispose() {
    _selectedTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'Active',
      'Inactive',
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('All Promotions'),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              fixedSize: Size(24, 24),
              iconSize: 22,
              backgroundColor: context.colorScheme.secondary,
              foregroundColor: context.colorScheme.onPrimary,
            ),
            onPressed: () {
              getIt<NavigationHelper>()
                  .push(context, AddUpdatePromotionsView());
            },
            icon: Icon(Icons.add),
          ).space(height: 32, width: 32),
          20.width,
        ],
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
                                    ? context.colorScheme.primary
                                    : context.colorScheme.onPrimary,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                side: BorderSide(
                                    color: index == tabIndex
                                        ? Colors.transparent
                                        : context.colorScheme.outline
                                            .withOp(0.7)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24))),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                  fontSize: 12,
                                  color: index == tabIndex
                                      ? context.colorScheme.onPrimary
                                      : context.colorScheme.onPrimaryContainer
                                          .withOp(0.6),
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
            Expanded(child: BlocBuilder<AllPromotionsBloc, AllPromotionsState>(
              builder: (context, state) {
                if (state is AllPromotionsError) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is AllPromotionsLoaded) {
                  final promos = state.promos;
                  return ValueListenableBuilder(
                      valueListenable: _selectedTab,
                      builder: (context, tab, _) {
                        if (tab == 0) {
                          return list(promos
                              .where(
                                (element) => element.isActive ?? false,
                              )
                              .toList());
                        } else {
                          return list(promos
                              .where(
                                (element) => !(element.isActive ?? false),
                              )
                              .toList());
                        }
                      });
                }
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget list(List<PromotionInfo> promos) {
    return ListView.separated(
      separatorBuilder: (context, index) => 14.height,
      itemCount: promos.length,
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(20),
      itemBuilder: (context, index) {
        final promo = promos[index];

        String dateRange;
        if (promo.startDate == null || promo.endDate == null) {
          dateRange = '';
        }

        String formattedStartDate =
            DateFormat('MMM d, yyyy').format(promo.startDate!);
        String formattedEndDate =
            DateFormat('MMM d, yyyy').format(promo.endDate!);

        dateRange = '$formattedStartDate - $formattedEndDate';
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.colorScheme.outline.withOp(0.7),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      promo.promoTitle ?? "",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  10.width,
                  Text(
                    '${promo.discountPercentage ?? 0}% off',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.secondary),
                  ),
                ],
              ),
              8.height,
              FutureBuilder<List<String>>(
                future: fetchVehicleNames(promo.vehicleList ?? []),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Text(
                      'Vehicles: ${snapshot.data!.join(', ')}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color:
                            context.colorScheme.onPrimaryContainer.withOp(0.5),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              8.height,
              Text(
                dateRange,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: context.colorScheme.onPrimaryContainer.withOp(0.5),
                ),
              ),
              15.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton.outlined(
                      onPressed: () {
                        getIt<NavigationHelper>().push(
                            context,
                            AddUpdatePromotionsView(
                              promotion: promo,
                              assignedVehicles: promo.vehicleList ?? [],
                            ));
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        Assets.iconsEdit2,
                        color:
                            context.colorScheme.onPrimaryContainer.withOp(0.5),
                        height: 18,
                        width: 18,
                      )).space(height: 30, width: 30),
                  12.width,
                  IconButton.outlined(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (c) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 27),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    Assets.iconsDelete,
                                    height: 34,
                                    color: context.colorScheme.primary,
                                    width: 34,
                                  ),
                                  24.height,
                                  Text(
                                    'Are you sure you want to delete this promotion?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  24.height,
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(c).pop();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: context
                                                    .colorScheme.secondary),
                                          ),
                                        ).space(height: 48),
                                      ),
                                      Expanded(
                                        child: CustomElevatedButton(
                                          onPressed: () async {
                                            final utils = getIt<Utils>();
                                            Navigator.of(c).pop();
                                            final repo =
                                                getIt<PromotionRepository>();

                                            try {
                                              final res =
                                                  await repo.deletePromotion(
                                                      promo.id.toString());
                                              if (mounted && context.mounted) {
                                                context
                                                    .read<AllPromotionsBloc>()
                                                    .add(
                                                        LoadAllPromotionsEvent());
                                                utils.showSuccessFlushBar(
                                                  context,
                                                  message: res.message ??
                                                      "Promotion Deleted Successfully",
                                                );
                                              }
                                            } catch (e, stackTrace) {
                                              if (context.mounted) {
                                                debugPrint(
                                                    stackTrace.toString());
                                                debugPrint(e.toString());
                                                utils.showErrorFlushBar(context,
                                                    message: e.toString());
                                              }
                                            }
                                          },
                                          text: 'Delete',
                                        ).space(height: 48),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        Assets.iconsDelete,
                        color:
                            context.colorScheme.onPrimaryContainer.withOp(0.5),
                        height: 18,
                        width: 18,
                      )).space(height: 30, width: 30),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<List<String>> fetchVehicleNames(
      List<VehicleModel> vehicleModels) async {
    return await Future.wait(vehicleModels.map(
      (e) => getVehicleName(e.carTypeId ?? "", e.carModelId ?? ""),
    ));
  }

  Future<String> getVehicleName(String typeId, String modelId) async {
    final state = context.read<VehicleAllTypesBloc>().state;

    String vehicleType = '';
    if (state is VehicleAllTypesLoaded) {
      vehicleType = state.allTypes
              .where(
                (element) => element.id == typeId,
              )
              .firstOrNull
              ?.typeName ??
          "";
    }
    final model = await getIt<MasterDataRepository>()
        .getVehicleModelModelById(vehicleModelId: modelId);
    return "$vehicleType ${model?.modelName ?? ""}";
  }
}
