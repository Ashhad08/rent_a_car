import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/extensions.dart';
import '../../../../domain/services/session_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../add_fuel_rates/add_fuel_rates.dart';
import '../../add_new_vehicle_view/add_new_vehicle_view.dart';
import '../../all_expenses_view/all_expenses_view.dart';
import '../../all_payment_vouchers_view/all_payment_vouchers_view.dart';
import '../../all_promotions_view/all_promotions_view.dart';
import '../../auth/login_view/login_view.dart';
import '../../day_book_view/day_book_view.dart';
import '../../rental_requests_view/rental_requests_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> drawerItems = [
      {
        'icon': Assets.iconsReturnVehicle,
        'title': 'Add New Vehicle',
        'nextScreen': AddNewVehicleView(),
      },
      {
        'icon': Assets.iconsCarFront,
        'title': 'Rental Requests',
        'nextScreen': RentalRequestsView(),
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
        'title': 'Receipt Vouchers',
        'nextScreen': AllPaymentVouchersView(),
      },
      {
        'icon': Assets.iconsExpenses,
        'title': 'Expenses',
        'nextScreen': AllExpensesView(),
      },
      {
        'icon': Assets.iconsDayBook,
        'title': 'Day Book',
        'nextScreen': DayBookView(),
      },
    ];
    return Drawer(
      backgroundColor: getIt<AppColors>().kCardColor,
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
                color: getIt<AppColors>().kPrimaryColor,
              ),
              8.width,
              Text(
                'Afaq Technologies',
                style: TextStyle(
                    color: getIt<AppColors>().kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          40.height,
          Text(
            'Rent-A-Car',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: context.colorScheme.onPrimary,
            ),
          ),
          40.height,
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
              onTap: () async {
                try {
                  await SessionManager().clearSession();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                      (route) => false,
                    );
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              }),
        ],
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
          tileColor: getIt<AppColors>().kPrimaryColor,
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
            color: context.colorScheme.secondary,
          ),
          title: Text(
            title,
            style: TextStyle(
                color: context.colorScheme.secondary,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
