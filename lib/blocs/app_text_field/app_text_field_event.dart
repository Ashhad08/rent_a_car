part of 'app_text_field_bloc.dart';

@immutable
abstract class AppTextFieldEvent extends Equatable {
  const AppTextFieldEvent();

  @override
  List<Object> get props => [];
}

class InitObscureTextEvent extends AppTextFieldEvent {
  final bool isPasswordField;

  const InitObscureTextEvent(this.isPasswordField);

  @override
  List<Object> get props => [isPasswordField];
}

class ToggleObscureTextEvent extends AppTextFieldEvent {}
