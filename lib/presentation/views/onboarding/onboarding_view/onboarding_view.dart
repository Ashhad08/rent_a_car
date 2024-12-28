import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/extensions.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../auth/login_view/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _primaryController = PageController();
  final _secondaryController   = PageController();
  final List<(String, String, String)> _onboardingData = [
    (
      'Drive Your Dream Car Today!',
      'Choose from a wide range of vehicles tailored to your needs.',
      Assets.imagesOnboarding1,
    ),
    (
      'Rent Anytime, Anywhere',
      'Convenient booking at your fingertips, wherever you are.',
      Assets.imagesOnboarding2,
    ),
    (
      'Experience Hassle-Free Rentals.',
      'Affordable, quick, and seamless car rental services.',
      Assets.imagesOnboarding3,
    ),
  ];

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColoredBox(
              color: context.colorScheme.primary.withOp(0.8),
              child: PageView.builder(
                controller: _primaryController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) =>
                    Image.asset(_onboardingData[index].$3),
              ),
            ).space(
              height: context.screenHeight * 0.5,
              width: double.infinity,
            ),
            20.height,
            SmoothPageIndicator(
              controller: _primaryController,
              count: _onboardingData.length,
              effect: ExpandingDotsEffect(
                dotWidth: 10,
                dotHeight: 10,
                radius: 10,
                activeDotColor: context.colorScheme.primary,
                dotColor: context.colorScheme.outline.withOp(.5),
              ),
            ),
            20.height,
            PageView.builder(
              controller: _secondaryController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Text(
                      _onboardingData[index].$1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    10.height,
                    Text(
                      _onboardingData[index].$2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.outline.withOp(0.8)),
                    ),
                  ],
                ),
              ),
            ).space(
              height: context.screenHeight * 0.2,
              width: double.infinity,
            ),
            20.height,
            ListenableBuilder(
              listenable: Listenable.merge([
                _primaryController,
                _secondaryController,
              ]),
              builder: (context, _) {
                final isLastPage =
                    (_primaryController.page ?? 0).round() == 2 ||
                        (_secondaryController.page ?? 0).round() == 2;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isLastPage) {
                        getIt<NavigationHelper>()
                            .pushReplacement(context, const LoginView());
                      } else {
                        await Future.wait([
                          _primaryController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          ),
                          _secondaryController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          ),
                        ]);
                      }
                    },
                    child: Text(isLastPage ? 'Let\'s Go' : 'Next'),
                  ).space(height: 56, width: double.infinity),
                );
              },
            ),
            10.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListenableBuilder(
                listenable: _primaryController,
                builder: (context, _) {
                  final isLastPage =
                      (_primaryController.page ?? 0).round() == 2 ||
                          (_secondaryController.page ?? 0).round() == 2;
                  if (!isLastPage) {
                    return TextButton(
                      onPressed: () {
                        _primaryController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                        _secondaryController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text('Skip'),
                    ).space(width: double.infinity);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
