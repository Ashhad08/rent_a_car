import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../../constants/extensions.dart';
import '../../../../domain/implementations/auth/auth_repository.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../../../utils/utils.dart';
import '../../../elements/app_text_field.dart';
import '../../../elements/custom_elevated_button.dart';
import '../../bottom_nav_bar/bottom_nav_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController(text: 'admin@gmail.com');
  final _emailNode = FocusNode();
  final _passwordController = TextEditingController(text: '123');
  final _passwordNode = FocusNode();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _emailNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingBloc(),
      child: Builder(builder: (context) {
        return LoadingOverlay(
          isLoading: context.select((LoadingBloc bloc) => bloc.state.isLoading),
          progressIndicator: CircularProgressIndicator.adaptive(),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text(
                'Login',
                style: TextStyle(color: context.colorScheme.onPrimary),
              ),
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(child: ColoredBox(color: Colors.black)),
                Positioned.fill(
                    child: Opacity(
                        opacity: 0.2,
                        child: Image.asset(
                          Assets.imagesLoginBg,
                          fit: BoxFit.cover,
                        ))),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFA7910A),
                          Color(0xFF1D1B0C),
                        ],
                      ),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 14),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Form(
                        key: _key,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Log In',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: context.colorScheme.onPrimary),
                            ),
                            4.height,
                            Text(
                              'Manage you rental services with ease',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: context.colorScheme.onPrimary),
                            ),
                            34.height,
                            AppTextField(
                              controller: _emailController,
                              focusNode: _emailNode,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Kindly enter email';
                                } else if (v.isNotEmpty && !v.isEmail) {
                                  return 'Enter valid email';
                                }
                                return null;
                              },
                              onFieldSubmitted: (p0) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordNode);
                              },
                              hintText: 'Enter email',
                              prefixIcon: const Icon(
                                CupertinoIcons.mail_solid,
                                size: 22,
                              ),
                            ),
                            18.height,
                            AppTextField(
                              controller: _passwordController,
                              focusNode: _passwordNode,
                              hintText: 'Enter password',
                              isPasswordField: true,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Kindly enter password';
                                }
                                return null;
                              },
                              prefixIcon: const Icon(
                                CupertinoIcons.lock_fill,
                                size: 22,
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: TextButton(
                            //     onPressed: () {},
                            //     child: Text(
                            //       'Forgot password?',
                            //       style: TextStyle(
                            //           fontSize: 14,
                            //           color: context.colorScheme.primary),
                            //     ),
                            //   ),
                            // ),
                            50.height,
                            CustomElevatedButton(
                              onPressed: () async {
                                final utils = getIt<Utils>();
                                if (_key.currentState!.validate() &&
                                    !context
                                        .read<LoadingBloc>()
                                        .state
                                        .isLoading) {
                                  final repo = getIt<AuthRepository>();

                                  try {
                                    context
                                        .read<LoadingBloc>()
                                        .add(StartLoading());
                                    final res = await repo.login(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim());
                                    if (mounted && context.mounted) {
                                      context
                                          .read<LoadingBloc>()
                                          .add(StopLoading());
                                      getIt<NavigationHelper>().pushReplacement(
                                          context, const BottomNavBar());
                                      utils.showSuccessFlushBar(context,
                                          message: res.message ??
                                              "LoggedIn Successfully");
                                    }
                                  } catch (e, stackTrace) {
                                    if (context.mounted) {
                                      debugPrint(stackTrace.toString());
                                      context
                                          .read<LoadingBloc>()
                                          .add(StopLoading());
                                      utils.showErrorFlushBar(context,
                                          message: e.toString());
                                    }
                                  }
                                }
                              },
                              text: 'Login',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
