import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/extensions.dart';

class PieChartView extends StatefulWidget {
  const PieChartView({super.key});

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
    final appColors = getIt<AppColors>();
    final data = [
      {'color': appColors.kLightBlue, 'value': 40.0, 'title': '150'},
      {'color': appColors.kRed, 'value': 15.0, 'title': '44'},
      {'color': appColors.kGreen, 'value': 30.0, 'title': '53'},
      {'color': appColors.kYellow, 'value': 10.0, 'title': '44'},
    ];

    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      return PieChartSectionData(
        color: data[i]['color'] as Color,
        value: data[i]['value'] as double,
        title: data[i]['title'] as String,
        titleStyle: const TextStyle(fontSize: 12),
        radius: isTouched ? 45.0 : 40.0,
        badgeWidget: CircleAvatar(
          radius: 5,
          backgroundColor: data[i]['color'] as Color,
        ),
        badgePositionPercentageOffset: 1.3,
        titlePositionPercentageOffset: 1.7,
      );
    });
  }
}
