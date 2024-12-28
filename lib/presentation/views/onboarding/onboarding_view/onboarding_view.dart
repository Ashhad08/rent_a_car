import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/extensions.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../../elements/custom_elevated_button.dart';
import '../../auth/login_view/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _primaryController = PageController();
  final _secondaryController = PageController();
  final List<(String, String, String)> _onboardingData = [
    (
      'Instant Car Rental',
      'Browse, select, and book your deal vehicle in minutes. From compact cars to luxury, SUVs, lind the perfect ride for any occasion.',
      Assets.imagesOnboarding1,
    ),
    (
      'Flexible Booking Options',
      'Enjoy hassle-free rentals with flexible pick- up and drop locations . Real time availability and instant confirmations make travel planning a breeze.',
      Assets.imagesOnboarding2,
    ),
    (
      'Seamless Travel Experience',
      'Transparent pricing, detailed vehicle information, and 24/7 customer support. Your journey starts with just a few taps on our user-friendly app.',
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
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _primaryController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) => Image.asset(
                _onboardingData[index].$3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ListenableBuilder(
              listenable: _primaryController,
              builder: (context, _) {
                if (_primaryController.hasClients &&
                    _secondaryController.hasClients) {
                  final isLastPage =
                      (_primaryController.page?.round() ?? 0) == 2 ||
                          (_secondaryController.page?.round() ?? 0) == 2;

                  if (!isLastPage) {
                    return SafeArea(
                      child: TextButton(
                        onPressed: () async {
                          await Future.wait([
                            _primaryController.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            ),
                            _secondaryController.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            ),
                          ]);
                        },
                        child: const Text('Skip'),
                      ),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.scrim.withOp(0.25),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.onPrimary.withOp(0.25),
                    offset: Offset(0, -1),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                    child: Column(
                      children: [
                        PageView.builder(
                          controller: _secondaryController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _onboardingData.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              Text(
                                _onboardingData[index].$1,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: context.colorScheme.onPrimary),
                              ),
                              10.height,
                              Text(
                                _onboardingData[index].$2,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context.colorScheme.onPrimary),
                              ),
                            ],
                          ),
                        ).space(
                          height: context.screenHeight * 0.15,
                          width: double.infinity,
                        ),
                        SmoothPageIndicator(
                          controller: _primaryController,
                          count: 3,
                          effect: WormEffect(
                            dotWidth: 16,
                            dotHeight: 6,
                            radius: 10,
                            activeDotColor: context.colorScheme.secondary,
                            dotColor: context.colorScheme.outline,
                          ),
                        ),
                        24.height,
                        ListenableBuilder(
                          listenable: Listenable.merge([
                            _primaryController,
                            _secondaryController,
                          ]),
                          builder: (context, _) {
                            final isLastPage = _primaryController.hasClients &&
                                    _secondaryController.hasClients &&
                                    (_primaryController.page?.round() ?? 0) ==
                                        2 ||
                                (_secondaryController.page?.round() ?? 0) == 2;

                            return CustomElevatedButton(
                              text: isLastPage ? 'Lets Ride' : 'Continue',
                              onPressed: () async {
                                if (isLastPage) {
                                  getIt<NavigationHelper>().pushReplacement(
                                      context, const LoginView());
                                } else {
                                  await Future.wait([
                                    _primaryController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn,
                                    ),
                                    _secondaryController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn,
                                    ),
                                  ]);
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
