import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/booking/approved_bookings_bloc/approved_bookings_bloc.dart';
import 'blocs/booking/pending_bookings_bloc/pending_bookings_bloc.dart';
import 'blocs/customer/all_customers/all_customers_bloc.dart';
import 'blocs/expense/all_expenses_bloc/all_expenses_bloc.dart';
import 'blocs/master_data/all_fuel_types_bloc/all_fuel_types_bloc.dart';
import 'blocs/master_data/dashboard_bloc/dashboard_bloc.dart';
import 'blocs/master_data/expense_all_heads/expense_all_heads_bloc.dart';
import 'blocs/master_data/vehicle_all_colors_bloc/vehicle_all_colors_bloc.dart';
import 'blocs/master_data/vehicle_all_features_bloc/vehicle_all_features_bloc.dart';
import 'blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import 'blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import 'blocs/master_data/vehicle_models_bloc/vehicle_models_bloc.dart';
import 'blocs/owner/all_owners/all_owners_bloc.dart';
import 'blocs/payment_voucher/all_payment_vouchers_bloc/all_payment_vouchers_bloc.dart';
import 'blocs/promotion/all_promotions_bloc/all_promotions_bloc.dart';
import 'blocs/vehicle/all_vehicles_bloc/all_vehicles_bloc.dart';
import 'blocs/vehicle/available_for_rent_vehicles_bloc/available_for_rent_vehicles_bloc.dart';
import 'configurations/backend_configs.dart';
import 'configurations/error_messages.dart';
import 'constants/app_colors.dart';
import 'constants/extensions.dart';
import 'constants/theme.dart';
import 'domain/implementations/auth/auth_repository.dart';
import 'domain/implementations/booking/booking_repository.dart';
import 'domain/implementations/customer/customer_repository.dart';
import 'domain/implementations/expense/expense_repository.dart';
import 'domain/implementations/master_data/master_data_repository.dart';
import 'domain/implementations/owner_repository/owner_repository.dart';
import 'domain/implementations/payment_voucher/payment_voucher_repository.dart';
import 'domain/implementations/promotion/promotion_repository.dart';
import 'domain/implementations/vehicle/vehicle_repository.dart';
import 'domain/services/image_services.dart';
import 'navigation/navigation_helper.dart';
import 'network/network_repository.dart';
import 'presentation/views/splash_view/splash_view.dart';
import 'utils/utils.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  getIt.registerSingleton(NavigationHelper());
  getIt.registerSingleton(AppColors());
  getIt.registerSingleton(AppThemes(appColors: getIt<AppColors>()));
  getIt.registerSingleton(ErrorMessages());
  getIt.registerSingleton(BackendConfigs());
  getIt.registerSingleton(Utils());
  getIt.registerSingleton(NetworkRepository(
    errorMessages: getIt<ErrorMessages>(),
  ));
  getIt.registerSingleton(
      ImageServices(getIt<NetworkRepository>(), getIt<BackendConfigs>()));
  getIt.registerSingleton(MasterDataRepository(
    backendConfigs: getIt<BackendConfigs>(),
    networkRepository: getIt<NetworkRepository>(),
  ));
  getIt.registerSingleton(VehicleRepository(
      backendConfigs: getIt<BackendConfigs>(),
      networkRepository: getIt<NetworkRepository>(),
      imageServices: getIt<ImageServices>()));
  getIt.registerSingleton(OwnerRepository(
      backendConfigs: getIt<BackendConfigs>(),
      networkRepository: getIt<NetworkRepository>(),
      imageServices: getIt<ImageServices>()));
  getIt.registerSingleton(CustomerRepository(
      backendConfigs: getIt<BackendConfigs>(),
      networkRepository: getIt<NetworkRepository>(),
      imageServices: getIt<ImageServices>()));
  getIt.registerSingleton(PromotionRepository(
    backendConfigs: getIt<BackendConfigs>(),
    networkRepository: getIt<NetworkRepository>(),
  ));
  getIt.registerSingleton(BookingRepository(
    backendConfigs: getIt<BackendConfigs>(),
    networkRepository: getIt<NetworkRepository>(),
  ));
  getIt.registerSingleton(PaymentVoucherRepository(
    backendConfigs: getIt<BackendConfigs>(),
    networkRepository: getIt<NetworkRepository>(),
  ));
  getIt.registerSingleton(ExpenseRepository(
    backendConfigs: getIt<BackendConfigs>(),
    networkRepository: getIt<NetworkRepository>(),
  ));
  getIt.registerSingleton(AuthRepository(
    backendConfigs: getIt<BackendConfigs>(),
    networkRepository: getIt<NetworkRepository>(),
  ));
  runApp(const RentACar());
}

class RentACar extends StatelessWidget {
  const RentACar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VehicleAllColorsBloc>(
          lazy: false,
          create: (context) =>
              VehicleAllColorsBloc(getIt<MasterDataRepository>())
                ..add(LoadVehicleAllColorsEvent()),
        ),
        BlocProvider<VehicleAllFeaturesBloc>(
          lazy: false,
          create: (context) =>
              VehicleAllFeaturesBloc(getIt<MasterDataRepository>())
                ..add(LoadVehicleAllFeaturesEvent()),
        ),
        BlocProvider<VehicleAllTypesBloc>(
          lazy: false,
          create: (context) =>
              VehicleAllTypesBloc(getIt<MasterDataRepository>())
                ..add(LoadVehicleAllTypesEvent()),
        ),
        BlocProvider<AllFuelTypesBloc>(
          lazy: false,
          create: (context) => AllFuelTypesBloc(getIt<MasterDataRepository>())
            ..add(LoadAllFuelTypesEvent()),
        ),
        BlocProvider<VehicleAllMakesBloc>(
          lazy: false,
          create: (context) =>
              VehicleAllMakesBloc(getIt<MasterDataRepository>())
                ..add(LoadVehicleAllMakesEvent()),
        ),
        BlocProvider<ExpenseAllHeadsBloc>(
          lazy: false,
          create: (context) =>
              ExpenseAllHeadsBloc(getIt<MasterDataRepository>())
                ..add(LoadExpenseAllHeadsEvent()),
        ),
        BlocProvider<VehicleModelsBloc>(
          lazy: false,
          create: (context) => VehicleModelsBloc(getIt<MasterDataRepository>())
            ..add(LoadVehicleModelsEvent()),
        ),
        BlocProvider<AllVehiclesBloc>(
          create: (context) => AllVehiclesBloc(getIt<VehicleRepository>())
            ..add(LoadAllVehiclesEvent()),
        ),
        BlocProvider<AllOwnersBloc>(
          create: (context) => AllOwnersBloc(getIt<OwnerRepository>())
            ..add(LoadAllOwnersEvent()),
        ),
        BlocProvider<AllCustomersBloc>(
          create: (context) => AllCustomersBloc(getIt<CustomerRepository>())
            ..add(LoadAllCustomersEvent()),
        ),
        BlocProvider<AvailableForRentVehiclesBloc>(
          create: (context) =>
              AvailableForRentVehiclesBloc(getIt<VehicleRepository>())
                ..add(LoadAvailableForRentVehiclesEvent()),
        ),
        BlocProvider<AllPromotionsBloc>(
          create: (context) => AllPromotionsBloc(getIt<PromotionRepository>())
            ..add(LoadAllPromotionsEvent()),
        ),
        BlocProvider<PendingBookingsBloc>(
          create: (context) => PendingBookingsBloc(getIt<BookingRepository>())
            ..add(LoadPendingBookingsEvent()),
        ),
        BlocProvider<ApprovedBookingsBloc>(
          create: (context) => ApprovedBookingsBloc(getIt<BookingRepository>())
            ..add(LoadApprovedBookingsEvent()),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(getIt<MasterDataRepository>())
            ..add(LoadDashboardData()),
        ),
        BlocProvider<AllPaymentVouchersBloc>(
          create: (context) =>
              AllPaymentVouchersBloc(getIt<PaymentVoucherRepository>())
                ..add(LoadAllPaymentVouchersEvent()),
        ),
        BlocProvider<AllExpensesBloc>(
          create: (context) => AllExpensesBloc(getIt<ExpenseRepository>())
            ..add(LoadAllExpensesEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Rent A Car Admin',
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        darkTheme: getIt<AppThemes>().darkTheme,
        theme: getIt<AppThemes>().darkTheme,
        themeMode: ThemeMode.dark,
        home: const SplashView(),
      ),
    );
  }
}
