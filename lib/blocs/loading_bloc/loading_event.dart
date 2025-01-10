part of 'loading_bloc.dart';

sealed class LoadingEvent extends Equatable {
  const LoadingEvent();
}

class StartLoading extends LoadingEvent {
  @override
  List<Object?> get props => [];
}

class StopLoading extends LoadingEvent {
  @override
  List<Object?> get props => [];
}
