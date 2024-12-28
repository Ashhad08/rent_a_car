import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/extensions.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../../elements/app_text_field.dart';
import '../../vehicle/all_vehicles_view/all_vehicles_view.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.height,
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              30.height,
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.colorScheme.onPrimary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter your information and login to your account',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                    20.height,
                    const Text(
                      'Email',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    8.height,
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
                        CupertinoIcons.mail,
                        size: 22,
                      ),
                    ),
                    15.height,
                    const Text(
                      'Password',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    8.height,
                    AppTextField(
                      controller: _passwordController,
                      focusNode: _passwordNode,
                      hintText: 'Enter password',
                      isPasswordField: true,
                      prefixIcon: const Icon(
                        CupertinoIcons.lock,
                        size: 22,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forget password?',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              50.height,
              ElevatedButton(
                onPressed: () {
                  getIt<NavigationHelper>()
                      .pushReplacement(context, const AllVehiclesView());
                },
                child: const Text('Login'),
              ).space(height: 56, width: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}
