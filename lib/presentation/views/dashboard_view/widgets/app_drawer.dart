import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/extensions.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../../elements/gradient_body.dart';
import '../../add_fuel_rates/add_fuel_rates.dart';
import '../../all_promotions_view/all_promotions_view.dart';
import '../../rental_requests_view/rental_requests_view.dart';
import '../../return_vehicle_view/return_vehicle_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> drawerItems = [
      {
        'icon': Assets.iconsCarFront,
        'title': 'Rental Requests',
        'nextScreen': RentalRequestsView(),
      },
      {
        'icon': Assets.iconsReturnVehicle,
        'title': 'Return Vehicle',
        'nextScreen': ReturnVehicleView(),
      },
      {
        'icon': Assets.iconsPromotions,
        'title': 'All Promotions',
        'nextScreen': AllPromotionsView(),
      },
      {
        'icon': Assets.iconsFuel,
        'title': 'Add Fuel Rates',
        'nextScreen': AddFuelRates(),
      },
      {
        'icon': Assets.iconsReceipetVoucher,
        'title': 'Receipt Voucher',
        'nextScreen': SizedBox(),
      },
      {
        'icon': Assets.iconsExpenses,
        'title': 'Expenses',
        'nextScreen': SizedBox(),
      },
      {
        'icon': Assets.iconsDayBook,
        'title': 'Day Book',
        'nextScreen': SizedBox(),
      },
    ];
    return Drawer(
      child: GradientBody(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.iconsAfaqTech,
                  height: 24,
                  width: 24,
                  color: context.colorScheme.primary,
                ),
                8.width,
                Text(
                  'Afaq Technologies',
                  style: TextStyle(
                      color: context.colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            30.height,
            Text(
              'Rent-A-Car',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: context.colorScheme.secondary,
              ),
            ),
            20.height,
            ...drawerItems.map(
              (e) => _buildDrawerTile(
                  context: context,
                  icon: e['icon'],
                  onTap: () {
                    getIt<NavigationHelper>().pop(context);
                    getIt<NavigationHelper>().push(context, e["nextScreen"]);
                  },
                  title: e['title']),
            ),
            _buildDrawerTile(
                context: context,
                title: 'Logout',
                icon: Assets.iconsLogout,
                onTap: () {}),
          ],
        ),
      ),
    );
  }

  _buildDrawerTile({
    required BuildContext context,
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: onTap,
          dense: true,
          tileColor: context.colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          leading: Image.asset(
            icon,
            color: context.colorScheme.secondary,
            colorBlendMode: BlendMode.srcIn,
            height: 20,
            width: 20,
          ),
          trailing: Icon(
            Icons.adaptive.arrow_forward,
            size: 20,
            color: context.colorScheme.onPrimary,
          ),
          title: Text(
            title,
            style: TextStyle(
                color: context.colorScheme.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
