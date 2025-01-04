import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../all_customers_view/all_customers_view.dart';
import '../all_vehicles_view/all_vehicles_view.dart';
import '../available_for_rent_vehicles_view/available_for_rent_vehicles_view.dart';
import '../on_rent_vehicles_view/on_rent_vehicles_view.dart';
import 'widgets/app_drawer.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/legend_widget.dart';
import 'widgets/pie_chart_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0336, 0.2951, 0.5899, 0.7541, 0.8734],
            colors: [
              Color(0xFFC0E2F3),
              Color(0xFFFFFFFF),
              Color(0xFFE6E3FF),
              Color(0xFFF2F2F2),
              Color(0xFFF9FBFC),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildDashboardRow([
                    DashboardCard(
                      title: 'Total Vehicles'.toUpperCase(),
                      data: '150',
                      icon: Assets.iconsCar,
                      nextScreen: const AllVehiclesView(),
                    ),
                    DashboardCard(
                      title: 'On Available'.toUpperCase(),
                      data: '53',
                      icon: Assets.iconsCar,
                      nextScreen: const AvailableForRentVehiclesView(),
                    ),
                  ]),
                  16.height,
                  _buildDashboardRow([
                    DashboardCard(
                      title: 'On Rent'.toUpperCase(),
                      data: '44',
                      icon: Assets.iconsRentCar,
                      nextScreen: const OnRentVehiclesView(),
                    ),
                    DashboardCard(
                      title: 'Customers'.toUpperCase(),
                      data: '44',
                      icon: Assets.iconsCustomers,
                      nextScreen: const AllCustomersView(),
                    ),
                  ]),
                  const PieChartView(),
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
              ),
            ),
          ),
        ),
      ),
    );
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
