part of 'all_owners_bloc.dart';

sealed class AllOwnersState extends Equatable {
  const AllOwnersState();
}

final class AllOwnersLoading extends AllOwnersState {
  @override
  List<Object> get props => [];
}

final class AllOwnersLoaded extends AllOwnersState {
  final List<OwnerModel> _owners;

  List<OwnerModel> get owners => _owners;

  const AllOwnersLoaded({required List<OwnerModel> owners}) : _owners = owners;

  @override
  List<Object> get props => [_owners];
}

final class AllOwnersError extends AllOwnersState {
  final String _error;

  String get error => _error;

  const AllOwnersError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
