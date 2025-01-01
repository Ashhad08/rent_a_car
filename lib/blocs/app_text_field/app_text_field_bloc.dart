import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_text_field_event.dart';
part 'app_text_field_state.dart';

class AppTextFieldBloc extends Bloc<AppTextFieldEvent, AppTextFieldState> {
  AppTextFieldBloc() : super(const AppTextFieldState(obscureText: false)) {
    on<InitObscureTextEvent>((event, emit) {
      emit(state.copyWith(obscureText: event.isPasswordField));
    });

    on<ToggleObscureTextEvent>((event, emit) {
      emit(state.copyWith(obscureText: !state.obscureText));
    });
  }
}
