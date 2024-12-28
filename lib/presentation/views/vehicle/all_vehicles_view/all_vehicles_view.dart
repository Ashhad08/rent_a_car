import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/vehicle/all_vehicles/all_vehicles_bloc.dart';
import '../../../../constants/extensions.dart';

class AllVehiclesView extends StatelessWidget {
  const AllVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Vehicles'),
      ),
      body: BlocBuilder<AllVehiclesBloc, AllVehiclesState>(
        builder: (context, state) {
          if (state is AllVehiclesLoaded) {
            return RefreshIndicator.adaptive(
              onRefresh: () async =>
                  context.read<AllVehiclesBloc>().add(LoadAllVehiclesEvent()),
              child: ListView.separated(
                separatorBuilder: (context, index) => 16.height,
                padding: const EdgeInsets.all(16),
                itemCount: state.allVehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = state.allVehicles[index];
                  return Container(
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(12)
                    // ),
                    //margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOp(0.1),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((vehicle.photos ?? []).isNotEmpty) ...[
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: CachedNetworkImage(
                              imageUrl: vehicle.photos!.first,
                              height: 150,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          const Divider(
                            height: 0,
                          )
                        ],
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${vehicle.carMake} ${vehicle.carModel} ${vehicle.yearOfModel}',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    vehicle.registrationNo ?? "",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              5.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 22,
                                        color: context.colorScheme.outline,
                                      ),
                                      2.width,
                                      Text(vehicle.registeredCity ?? "")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.color_lens,
                                        size: 22,
                                        color: context.colorScheme.outline,
                                      ),
                                      2.width,
                                      Text(vehicle.color ?? "")
                                    ],
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      text: "Rs.${vehicle.ratePerDay}",
                                      children: [
                                        TextSpan(
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  context.colorScheme.outline),
                                          text: "/Day",
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (state is AllVehiclesError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
