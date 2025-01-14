part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
}

final class LoadDashboardData extends DashboardEvent {
  @override
  List<Object?> get props => [];
}

final class RefreshDashboardData extends DashboardEvent {
  @override
  List<Object?> get props => [];
}
