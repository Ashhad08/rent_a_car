import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/extensions.dart';
import '../../../../data/models/master_data/dashboard_model.dart';

class PieChartView extends StatefulWidget {
  const PieChartView({super.key, required this.dashboardData});

  final DashboardModel dashboardData;

  @override
  State<PieChartView> createState() => _PieChartViewState();
}

class _PieChartViewState extends State<PieChartView> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          pieTouchData: PieTouchData(
            touchCallback: (event, pieTouchResponse) {
              setState(() {
                touchedIndex = (event.isInterestedForInteractions &&
                        pieTouchResponse?.touchedSection != null)
                    ? pieTouchResponse!.touchedSection!.touchedSectionIndex
                    : -1;
              });
            },
          ),
          centerSpaceRadius: 60,
          sections: _showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    final dashboardData = widget.dashboardData;

    // Data for the pie chart
    final data = [
      {
        'value': dashboardData.allVehicles?.toDouble() ?? 0,
        'title': '${dashboardData.allVehicles ?? 0}',
      },
      {
        'value': dashboardData.availableVehicles?.toDouble() ?? 0,
        'title': '${dashboardData.availableVehicles ?? 0}',
      },
      {
        'value': dashboardData.allCustomers?.toDouble() ?? 0,
        'title': '${dashboardData.allCustomers ?? 0}',
      },
      {
        'value': dashboardData.onRentVehicles?.toDouble() ?? 0,
        'title': '${dashboardData.onRentVehicles ?? 0}',
      },
    ];

    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      return PieChartSectionData(
        color: isTouched
            ? getIt<AppColors>().kPrimaryColor
            : getIt<AppColors>().kCardColor,
        value: data[i]['value'] as double,
        title: data[i]['title'] as String,
        titleStyle:
            TextStyle(fontSize: 12, color: context.colorScheme.onPrimary),
        radius: isTouched ? 45.0 : 40.0,
        badgeWidget: CircleAvatar(
          radius: 5,
          backgroundColor: isTouched
              ? getIt<AppColors>().kPrimaryColor
              : getIt<AppColors>().kCardColor,
        ),
        badgePositionPercentageOffset: 1.3,
        titlePositionPercentageOffset: 1.7,
      );
    });
  }
}
