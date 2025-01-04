import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../add_new_vehicle_view/add_new_vehicle_view.dart';
import '../add_owner_info_view/add_owner_info_view.dart';
import '../all_owners_view/all_owners_view.dart';
import '../dashboard_view/dashboard_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  final _screens = [DashboardView(), AllOwnersView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _currentIndex,
        builder: (context, value, child) => Stack(
          children: [
            Positioned.fill(child: _screens.elementAt(value)),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 83,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFF1F1F1),
                            Color(0xFFF9FBFC),
                          ],
                          stops: [0.0288, 0.2078],
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildNavItem(
                            index: 0,
                            label: 'Dashboard',
                            iconPath: Assets.iconsDashboard,
                            context: context,
                          ),
                          _buildNavItem(
                            index: 1,
                            label: 'Owners',
                            iconPath: Assets.iconsOwners,
                            context: context,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: OutlinedButton(
                      onPressed: () {
                        if (value == 0) {
                          getIt<NavigationHelper>()
                              .push(context, AddNewVehicleView());
                        } else if (value == 1) {
                          getIt<NavigationHelper>()
                              .push(context, AddOwnerInfoView());
                        }
                      },
                      style: OutlinedButton.styleFrom(
                          fixedSize: Size(64, 64),
                          backgroundColor: Color(0xffF9FBFC),
                          padding: EdgeInsets.zero,
                          side: BorderSide(color: Color(0xffF2F5F6), width: 6)),
                      child: Image.asset(
                        Assets.iconsReturnVehicle,
                        height: 44,
                        width: 44,
                        color: context.colorScheme.primary,
                      ),
                    ).space(height: 78, width: 78),
                  )
                ],
              ).space(height: 122, width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required String iconPath,
    required BuildContext context,
  }) {
    final bool isSelected = _currentIndex.value == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          _currentIndex.value = index;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              height: 24,
              width: 24,
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.outline,
            ),
            4.height,
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.outline,
              ),
            ),
            if (isSelected)
              Image.asset(
                Assets.iconsBottomBarShadow,
                height: 19,
                color: context.colorScheme.primary,
                width: double.infinity,
              )
          ],
        ),
      ),
    );
  }
}
