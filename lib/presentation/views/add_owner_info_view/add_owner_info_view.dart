import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../blocs/owner/all_owners/all_owners_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/owner/owner_model.dart';
import '../../../domain/implementations/owner_repository/owner_repository.dart';
import '../../../domain/services/image_services.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';

class AddOwnerInfoView extends StatefulWidget {
  const AddOwnerInfoView({super.key});

  @override
  State<AddOwnerInfoView> createState() => _AddOwnerInfoViewState();
}

class _AddOwnerInfoViewState extends State<AddOwnerInfoView> {
  final _ownerCodeController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _ownerDateFromController = TextEditingController();
  final _ownerFatherNameController = TextEditingController();
  final _ownerCNICController = TextEditingController();
  final _ownerAddressController = TextEditingController();
  final _ownerCityController = TextEditingController();
  final _ownerMobileNumberController = TextEditingController();
  final _ownerResidenceNumberController = TextEditingController();
  final _ownerProfessionController = TextEditingController();
  final ValueNotifier<File?> _file = ValueNotifier(null);

  @override
  void dispose() {
    _ownerCodeController.dispose();
    _ownerNameController.dispose();
    _ownerDateFromController.dispose();
    _ownerFatherNameController.dispose();
    _ownerCNICController.dispose();
    _ownerAddressController.dispose();
    _ownerCityController.dispose();
    _ownerMobileNumberController.dispose();
    _ownerResidenceNumberController.dispose();
    _ownerProfessionController.dispose();
    _file.dispose();
    super.dispose();
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingBloc(),
      child: Builder(builder: (context) {
        return LoadingOverlay(
          isLoading: context.select((LoadingBloc bloc) => bloc.state.isLoading),
          color: context.colorScheme.primary.withOp(0.2),
          progressIndicator: CircularProgressIndicator.adaptive(
            backgroundColor: context.colorScheme.onPrimary,
          ),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: getIt<Utils>().popIcon(context),
              title: const Text('Owner Information'),
            ),
            body: GradientBody(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 20),
                          decoration: BoxDecoration(
                            color: context.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: context.colorScheme.outline.withOp(0.7),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    ValueListenableBuilder(
                                        valueListenable: _file,
                                        builder: (context, file, _) {
                                          return GestureDetector(
                                            onTap: () async {
                                              final imageServices =
                                                  getIt<ImageServices>();
                                              await imageServices.pickImage(
                                                ImageSource.gallery,
                                                (file) {
                                                  _file.value = file;
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 92,
                                              width: 92,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: file == null
                                                      ? null
                                                      : DecorationImage(
                                                          image:
                                                              FileImage(file),
                                                          fit: BoxFit.cover),
                                                  border: Border.all(
                                                      color: context
                                                          .colorScheme.outline
                                                          .withOp(0.4))),
                                              alignment: Alignment.center,
                                              child: file == null
                                                  ? Text(
                                                      'Pick a image',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: context
                                                              .colorScheme
                                                              .outline
                                                              .withOp(0.7)),
                                                    )
                                                  : null,
                                            ),
                                          );
                                        }),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: context.colorScheme.outline
                                                .withOp(0.6)),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          Assets.iconsEdit,
                                          height: 16,
                                          width: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              20.height,
                              Text(
                                'Owner Code',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.5)),
                              ),
                              8.height,
                              AppTextField(
                                controller: _ownerCodeController,
                                hintText: 'Enter Owner Code',
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Kindly enter owner code";
                                  }
                                  return null;
                                },
                              ),
                              16.height,
                              Text(
                                'Date From',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.5)),
                              ),
                              8.height,
                              ListenableBuilder(
                                  listenable: _ownerDateFromController,
                                  builder: (context, _) {
                                    return AppTextField(
                                      controller: _ownerDateFromController,
                                      readOnly: true,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Kindly enter start date";
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now()
                                              .subtract(Duration(days: 10000)),
                                          lastDate: DateTime.now()
                                              .add(Duration(days: 100000)),
                                          currentDate: DateTime.now(),
                                          initialDate: DateTime.tryParse(
                                              _ownerDateFromController.text),
                                        );
                                        if (date != null) {
                                          _ownerDateFromController.text =
                                              DateFormat('MMM d yyyy')
                                                  .format(date);
                                          FocusManager.instance.primaryFocus!
                                              .unfocus();
                                        }
                                      },
                                      textInputType: TextInputType.datetime,
                                      suffix: Icon(CupertinoIcons.calendar),
                                      hintText: 'Select Start Date',
                                    );
                                  }),
                              16.height,
                              Text(
                                'Owner Name',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.5)),
                              ),
                              8.height,
                              AppTextField(
                                controller: _ownerNameController,
                                hintText: 'Enter Full Name',
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Kindly enter full name";
                                  }
                                  return null;
                                },
                              ),
                              16.height,
                              Text(
                                'Father Name',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.5)),
                              ),
                              8.height,
                              AppTextField(
                                controller: _ownerFatherNameController,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Kindly enter father name";
                                  }
                                  return null;
                                },
                                hintText: 'Enter Father Name',
                              ),
                              16.height,
                              Text(
                                'CNIC Number',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.5)),
                              ),
                              8.height,
                              AppTextField(
                                controller: _ownerCNICController,
                                hintText: 'Enter CNIC Number',
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Kindly enter CNIC number";
                                  }
                                  return null;
                                },
                              ),
                              16.height,
                              Text(
                                'Address',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.5)),
                              ),
                              8.height,
                              AppTextField(
                                controller: _ownerAddressController,
                                hintText: 'Enter Full Address',
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Kindly enter full address";
                                  }
                                  return null;
                                },
                              ),
                              16.height,
                              Text(
                                'City',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.5)),
                              ),
                              8.height,
                              AppTextField(
                                controller: _ownerCityController,
                                hintText: 'Enter Your City',
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Kindly enter city";
                                  }
                                  return null;
                                },
                              ),
                              16.height,
                              Text(
                                'Mobile No',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.5)),
                              ),
                              8.height,
                              AppTextField(
                                controller: _ownerMobileNumberController,
                                hintText: 'Enter Mobile Number',
                                textInputType: TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Kindly enter mobile number";
                                  } else if (val.isNotEmpty &&
                                      !val.isMobileNumber) {
                                    return 'Kindly enter valid number';
                                  }
                                  return null;
                                },
                              ),
                              16.height,
                              Text(
                                'Residence Phone',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.5)),
                              ),
                              8.height,
                              AppTextField(
                                textInputType: TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                controller: _ownerResidenceNumberController,
                                hintText: 'Enter Residence Phone',
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Kindly enter residence phone";
                                  } else if (val.isNotEmpty &&
                                      !val.isMobileNumber) {
                                    return 'Kindly enter valid phone';
                                  }
                                  return null;
                                },
                              ),
                              16.height,
                              Text(
                                'Profession',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: context
                                        .colorScheme.onPrimaryContainer
                                        .withOp(0.5)),
                              ),
                              8.height,
                              AppTextField(
                                controller: _ownerProfessionController,
                                hintText: 'Enter Profession',
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Kindly enter profession";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        34.height,
                        CustomElevatedButton(
                            onPressed: () async {
                              final utils = getIt<Utils>();
                              if (_key.currentState!.validate() &&
                                  !context
                                      .read<LoadingBloc>()
                                      .state
                                      .isLoading) {
                                if (_file.value == null) {
                                  context
                                      .read<LoadingBloc>()
                                      .add(StopLoading());
                                  utils.showErrorFlushBar(context,
                                      message:
                                          "Select a image for owner profile");
                                  return;
                                }
                                final repo = getIt<OwnerRepository>();

                                try {
                                  context
                                      .read<LoadingBloc>()
                                      .add(StartLoading());
                                  final res = await repo.createOwner(OwnerInfo(
                                    address:
                                        _ownerAddressController.text.trim(),
                                    city: _ownerCityController.text.trim(),
                                    cnic: _ownerCNICController.text.trim(),
                                    dateFrom: DateFormat('MMM d yyyy')
                                        .parse(_ownerDateFromController.text),
                                    fatherName:
                                        _ownerFatherNameController.text.trim(),
                                    mobileNumber: _ownerMobileNumberController
                                        .text
                                        .trim(),
                                    ownerCode: _ownerCodeController.text.trim(),
                                    ownerImage: _file.value!.path,
                                    ownerName: _ownerNameController.text.trim(),
                                    profession:
                                        _ownerProfessionController.text.trim(),
                                    resedenceNumber:
                                        _ownerResidenceNumberController.text
                                            .trim(),
                                    vehicles: [],
                                  ));
                                  if (mounted && context.mounted) {
                                    context
                                        .read<LoadingBloc>()
                                        .add(StopLoading());
                                    context
                                        .read<AllOwnersBloc>()
                                        .add(LoadAllOwnersEvent());
                                    getIt<NavigationHelper>().pop(context);
                                    utils.showSuccessFlushBar(context,
                                        message: res.message ??
                                            "Owner Added Successfully");
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
                            text: 'Save Information'),
                        20.height,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
