import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/extensions.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../../elements/app_text_field.dart';
import '../../../elements/custom_elevated_button.dart';
import '../../../elements/gradient_body.dart';
import '../../dashboard_view/dashboard_view.dart';

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
        title: const Text('Login'),
      ),
      body: GradientBody(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              const Text(
                'Log In',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              4.height,
              const Text(
                'Manage you rental services with ease',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
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
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              50.height,
              CustomElevatedButton(
                onPressed: () {
                  getIt<NavigationHelper>()
                      .pushReplacement(context, const DashboardView());
                },
                text: 'Login',
              ),
            ],
          ),
        ),
      )),
    );
  }
}
