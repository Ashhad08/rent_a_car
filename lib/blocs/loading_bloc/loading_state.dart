part of 'loading_bloc.dart';

final class LoadingState extends Equatable {
  final bool isLoading;

  const LoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}
