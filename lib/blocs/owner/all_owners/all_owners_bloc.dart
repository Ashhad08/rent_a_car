import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/owner/owner_model.dart';
import '../../../domain/implementations/owner_repository/owner_repository.dart';

part 'all_owners_event.dart';
part 'all_owners_state.dart';

class AllOwnersBloc extends Bloc<AllOwnersEvent, AllOwnersState> {
  final OwnerRepository _repository;

  AllOwnersBloc(this._repository) : super(AllOwnersLoading()) {
    on<LoadAllOwnersEvent>(_onLoadAllOwnersEvent);
  }

  Future<void> _onLoadAllOwnersEvent(
      LoadAllOwnersEvent event, Emitter<AllOwnersState> emit) async {
    try {
      emit(AllOwnersLoading());
      final owners = await _repository.getAllOwners();
      emit(AllOwnersLoaded(owners: owners));
    } catch (e) {
      emit(AllOwnersError(error: e.toString()));
    }
  }
}
