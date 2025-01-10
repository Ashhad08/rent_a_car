part of 'all_owners_bloc.dart';

sealed class AllOwnersEvent extends Equatable {
  const AllOwnersEvent();
}

final class LoadAllOwnersEvent extends AllOwnersEvent {
  @override
  List<Object> get props => [];
}
