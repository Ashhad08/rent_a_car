import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/master_data/vehicle_all_colors_bloc/vehicle_all_colors_bloc.dart';
import 'blocs/master_data/vehicle_all_features_bloc/vehicle_all_features_bloc.dart';
import 'blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import 'configurations/backend_configs.dart';
import 'configurations/error_messages.dart';
import 'constants/app_colors.dart';
import 'constants/extensions.dart';
import 'constants/theme.dart';
import 'domain/implementations/master_data/master_data_repository.dart';
import 'navigation/navigation_helper.dart';
import 'network/network_repository.dart';
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
  getIt.registerSingleton(MasterDataRepository(
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
