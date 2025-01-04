import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/extensions.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../../elements/app_text_field.dart';
import '../../../elements/custom_elevated_button.dart';
import '../../bottom_nav_bar/bottom_nav_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordNode = FocusNode();

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: context.colorScheme.onPrimary),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.imagesLoginBg), fit: BoxFit.cover)),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  decoration: BoxDecoration(
                    color: context.colorScheme.onPrimary.withOp(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                        onFieldSubmitted: (p0) {
                          FocusScope.of(context).requestFocus(_passwordNode);
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
                        prefixIcon: const Icon(
                          CupertinoIcons.lock_fill,
                          size: 22,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                                fontSize: 14,
                                color: context.colorScheme.secondary),
                          ),
                        ),
                      ),
                      50.height,
                      CustomElevatedButton(
                        onPressed: () {
                          getIt<NavigationHelper>()
                              .pushReplacement(context, const BottomNavBar());
                        },
                        text: 'Login',
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
