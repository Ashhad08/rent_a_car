part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();
}

final class DashboardLoading extends DashboardState {
  @override
  List<Object> get props => [];
}

final class DashboardLoaded extends DashboardState {
  final DashboardModel dashboardData;

  const DashboardLoaded({required this.dashboardData});

  @override
  List<Object> get props => [];
}

final class DashboardError extends DashboardState {
  final String error;

  const DashboardError({required this.error});

  @override
  List<Object> get props => [];
}
