import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/vehicle/all_vehicles/all_vehicles_bloc.dart';
import 'configurations/backend_configs.dart';
import 'configurations/error_messages.dart';
import 'constants/app_colors.dart';
import 'constants/extensions.dart';
import 'constants/theme.dart';
import 'domain/implementations/vehicle_api_repository.dart';
import 'navigation/navigation_helper.dart';
import 'network/network_repository.dart';
import 'presentation/views/auth/login_view/login_view.dart';
import 'presentation/views/onboarding/splash_view/splash_view.dart';
import 'utils/utils.dart';

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
  getIt.registerSingleton(VehicleApiRepository(
      backendConfigs: getIt<BackendConfigs>(),
      networkRepository: getIt<NetworkRepository>()));
  runApp(const RentACar());
}

class RentACar extends StatelessWidget {
  const RentACar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllVehiclesBloc>(
          create: (context) => AllVehiclesBloc(getIt<VehicleApiRepository>())
            ..add(LoadAllVehiclesEvent()),
        )
      ],
      child: MaterialApp(
        title: 'Rent A Car',
        debugShowCheckedModeBanner: false,
        theme: getIt<AppThemes>().lightTheme,
        home: const SplashView(),
      ),
    );
  }
}
