part of 'app_text_field_bloc.dart';

@immutable
class AppTextFieldState extends Equatable {
  final bool obscureText;

  const AppTextFieldState({required this.obscureText});

  AppTextFieldState copyWith({bool? obscureText}) {
    return AppTextFieldState(
      obscureText: obscureText ?? this.obscureText,
    );
  }

  @override
  List<Object> get props => [obscureText];
}
