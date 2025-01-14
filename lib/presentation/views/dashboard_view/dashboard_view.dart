import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/master_data/dashboard_bloc/dashboard_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../elements/gradient_body.dart';
import '../all_customers_view/all_customers_view.dart';
import '../all_vehicles_view/all_vehicles_view.dart';
import '../available_for_rent_vehicles_view/available_for_rent_vehicles_view.dart';
import '../on_rent_vehicles_view/on_rent_vehicles_view.dart';
import 'widgets/app_drawer.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/legend_widget.dart';
import 'widgets/pie_chart_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ModalRoute? modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    super.didPush();
    final dashboardState = context.read<DashboardBloc>().state;
    if (dashboardState is DashboardLoaded || dashboardState is DashboardError) {
      context.read<DashboardBloc>().add(RefreshDashboardData());
    }
  }

  @override
  void didPopNext() {
    super.didPopNext();
    final dashboardState = context.read<DashboardBloc>().state;
    if (dashboardState is DashboardLoaded || dashboardState is DashboardError) {
      context.read<DashboardBloc>().add(RefreshDashboardData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Dashboard'),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Image.asset(
                  Assets.iconsDrawer,
                  height: 24,
                  color: context.colorScheme.onPrimary,
                  width: 24,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: AppDrawer(),
        body: GradientBody(
            child: RefreshIndicator(
          onRefresh: () async =>
              context.read<DashboardBloc>().add(RefreshDashboardData()),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardError) {
                      return Center(
                        child: Text(
                          state.error,
                          style:
                              TextStyle(color: context.colorScheme.onPrimary),
                        ),
                      );
                    } else if (state is DashboardLoaded) {
                      return Column(
                        children: [
                          _buildDashboardRow([
                            DashboardCard(
                              title: 'Total Vehicles'.toUpperCase(),
                              data: (state.dashboardData.allVehicles ?? 0)
                                  .toString(),
                              icon: Assets.iconsCar,
                              nextScreen: const AllVehiclesView(),
                            ),
                            DashboardCard(
                              title: 'On Available'.toUpperCase(),
                              data: (state.dashboardData.availableVehicles ?? 0)
                                  .toString(),
                              icon: Assets.iconsCar,
                              nextScreen: const AvailableForRentVehiclesView(),
                            ),
                          ]),
                          16.height,
                          _buildDashboardRow([
                            DashboardCard(
                              title: 'On Rent'.toUpperCase(),
                              data: (state.dashboardData.onRentVehicles ?? 0)
                                  .toString(),
                              icon: Assets.iconsRentCar,
                              nextScreen: const OnRentVehiclesView(),
                            ),
                            DashboardCard(
                              title: 'Customers'.toUpperCase(),
                              data: (state.dashboardData.allCustomers ?? 0)
                                  .toString(),
                              icon: Assets.iconsCustomers,
                              nextScreen: const AllCustomersView(),
                            ),
                          ]),
                          PieChartView(
                            dashboardData: state.dashboardData,
                          ),
                          _buildLegendRow([
                            'Total Vehicles',
                            'Customers',
                          ]),
                          10.height,
                          _buildLegendRow([
                            'On Available',
                            'On Rent',
                          ]),
                          83.height,
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  },
                ),
              ),
            ),
          ),
        )));
  }

  Widget _buildDashboardRow(List<DashboardCard> cards) {
    return Row(
      children: cards
          .map((card) => Expanded(child: card))
          .expand((widget) => [widget, 10.width])
          .toList()
        ..removeLast(),
    );
  }

  Widget _buildLegendRow(List<String> legends) {
    return Row(
      children: legends
          .map((legend) => LegendWidget(
                title: legend,
              ))
          .expand((widget) => [widget, const Spacer()])
          .toList()
        ..removeLast(),
    );
  }
}
