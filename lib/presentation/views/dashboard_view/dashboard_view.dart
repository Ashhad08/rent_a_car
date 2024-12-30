import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../elements/gradient_body.dart';
import '../all_customers_view/all_customers_view.dart';
import '../all_vehicles_view/all_vehicles_view.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/legend_widget.dart';
import 'widgets/pie_chart_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = getIt<AppColors>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: GradientBody(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildDashboardRow([
                  DashboardCard(
                    color: appColors.kLightBlue,
                    title: 'Total Vehicles'.toUpperCase(),
                    data: '150',
                    icon: Assets.iconsCar,
                    nextScreen: const AllVehiclesView(),
                  ),
                  DashboardCard(
                    color: appColors.kGreen,
                    title: 'On Available'.toUpperCase(),
                    data: '53',
                    icon: Assets.iconsCar,
                    nextScreen: const SizedBox(),
                  ),
                ]),
                16.height,
                _buildDashboardRow([
                  DashboardCard(
                    color: appColors.kRed,
                    title: 'On Rent'.toUpperCase(),
                    data: '44',
                    icon: Assets.iconsRentCar,
                    nextScreen: const SizedBox(),
                  ),
                  DashboardCard(
                    color: appColors.kYellow,
                    title: 'Customers'.toUpperCase(),
                    data: '44',
                    icon: Assets.iconsCustomers,
                    nextScreen: const AllCustomersView(),
                  ),
                ]),
                const PieChartView(),
                _buildLegendRow([
                  (
                    'Total Vehicles',
                    appColors.kLightBlue,
                  ),
                  (
                    'Customers',
                    appColors.kYellow,
                  ),
                ]),
                10.height,
                _buildLegendRow([
                  (
                    'On Available',
                    appColors.kGreen,
                  ),
                  (
                    'On Rent',
                    appColors.kRed,
                  ),
                ]),
              ],
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

  Widget _buildLegendRow(List<(String, Color)> legends) {
    return Row(
      children: legends
          .map((legend) => LegendWidget(
                title: legend.$1,
                color: legend.$2,
              ))
          .expand((widget) => [widget, const Spacer()])
          .toList()
        ..removeLast(),
    );
  }
}
