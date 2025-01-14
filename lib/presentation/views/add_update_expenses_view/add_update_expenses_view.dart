import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/expense/all_expenses_bloc/all_expenses_bloc.dart';
import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../blocs/master_data/expense_all_heads/expense_all_heads_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/expense/expense_model.dart';
import '../../../data/models/master_data/expense_head_model.dart';
import '../../../domain/implementations/expense/expense_repository.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_drop_down.dart';
import '../../elements/custom_elevated_button.dart';
import '../../elements/gradient_body.dart';

class AddUpdateExpensesView extends StatefulWidget {
  const AddUpdateExpensesView({super.key, this.expense});

  final ExpenseModel? expense;

  @override
  State<AddUpdateExpensesView> createState() => _AddUpdateExpensesViewState();
}

class _AddUpdateExpensesViewState extends State<AddUpdateExpensesView> {
  MapEntry<String, String>? _head;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final ValueNotifier<String?> _id = ValueNotifier(null);

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _id.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.expense != null) {
      _id.value = widget.expense?.id;
      _head = MapEntry(widget.expense!.expenseHead!.id.toString(),
          widget.expense!.expenseHead!.expenseHeadName.toString());
      if (widget.expense!.date != null) {
        _dateController.text =
            DateFormat('MMM d yyyy').format(widget.expense!.date!);
      }
      _descriptionController.text = widget.expense!.description ?? "";
      _timeController.text = widget.expense!.time ?? "";
      _amountController.text = (widget.expense!.totalAmount ?? "0").toString();
    } else {
      getId();
    }
    super.initState();
  }

  getId() async {
    _id.value = await getIt<ExpenseRepository>().getAutoID();
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
              leading: getIt<Utils>().popIcon(context),
              title:
                  Text('${widget.expense != null ? 'Edit' : "Add"} Expenses'),
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
                        Text(
                          'Expense Voucher Id',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary),
                        ),
                        ValueListenableBuilder(
                            valueListenable: _id,
                            builder: (context, id, _) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: context.colorScheme.surface,
                                  ),
                                ),
                                child: Text(
                                  id ?? "",
                                  style: TextStyle(
                                      color: context.colorScheme.onPrimary),
                                ),
                              );
                            }),
                        18.height,
                        Text(
                          'Expense Head',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary),
                        ),
                        10.height,
                        BlocBuilder<ExpenseAllHeadsBloc, ExpenseAllHeadsState>(
                          builder: (context, state) {
                            return CustomDropDown(
                              errorMessageIfRequired:
                                  'Kindly Select Expense Head',
                              prefixIcon: Image.asset(
                                Assets.iconsExpenses,
                                height: 24,
                                width: 24,
                                color: getIt<AppColors>().kPrimaryColor,
                              ),
                              label: 'Select Expense Head',
                              dropdownMenuEntries: (state
                                      is ExpenseAllHeadsLoaded)
                                  ? (state.heads.map(
                                      (e) => MapEntry(
                                          e.id ?? "", e.expenseHeadName ?? ""),
                                    )).toList()
                                  : [],
                              onSelected: (val) {
                                if (val != null) {
                                  _head = val;
                                }
                              },
                              enabled: (state is ExpenseAllHeadsLoaded),
                              initialItem: _head,
                            );
                          },
                        ),
                        18.height,
                        Row(
                          spacing: 14,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: context.colorScheme.onPrimary),
                                ),
                                8.height,
                                ListenableBuilder(
                                    listenable: _dateController,
                                    builder: (context, _) {
                                      return AppTextField(
                                          readOnly: true,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return "Kindly enter date";
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            final date = await showDatePicker(
                                              context: context,
                                              firstDate: DateTime.now()
                                                  .subtract(
                                                      Duration(days: 10000)),
                                              lastDate: DateTime.now()
                                                  .add(Duration(days: 100000)),
                                              currentDate: DateTime.now(),
                                              initialDate: DateTime.tryParse(
                                                  _dateController.text),
                                            );
                                            if (date != null) {
                                              _dateController.text =
                                                  DateFormat('MMM d yyyy')
                                                      .format(date);
                                              FocusManager
                                                  .instance.primaryFocus!
                                                  .unfocus();
                                            }
                                          },
                                          controller: _dateController,
                                          hintText: 'MMM d yyyy');
                                    }),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: context.colorScheme.onPrimary,
                                  ),
                                ),
                                8.height,
                                ListenableBuilder(
                                    listenable: _timeController,
                                    builder: (context, _) {
                                      return AppTextField(
                                          readOnly: true,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return "Kindly enter time";
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            final time = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if (time != null) {
                                              final now = DateTime.now();
                                              final DateTime dateTime =
                                                  DateTime(
                                                      now.year,
                                                      now.month,
                                                      now.day,
                                                      time.hour,
                                                      time.minute);
                                              _timeController.text =
                                                  DateFormat('h:mm a')
                                                      .format(dateTime);

                                              FocusManager
                                                  .instance.primaryFocus!
                                                  .unfocus();
                                            }
                                          },
                                          controller: _timeController,
                                          hintText: '10:10 PM');
                                    }),
                              ],
                            )),
                          ],
                        ),
                        18.height,
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary),
                        ),
                        10.height,
                        AppTextField(
                            maxLines: 3,
                            controller: _descriptionController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Kindly enter details";
                              }
                              return null;
                            },
                            hintText: 'Enter Expense Details'),
                        18.height,
                        Text(
                          'Total Amount',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onPrimary),
                        ),
                        10.height,
                        AppTextField(
                          controller: _amountController,
                          hintText: '2000',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Kindly enter details";
                            } else if (val.isNotEmpty &&
                                !val.isDecimalPositiveNumber) {
                              return 'Enter valid amount';
                            }
                            return null;
                          },
                        ),
                        34.height,
                        CustomElevatedButton(
                          onPressed: () async {
                            final utils = getIt<Utils>();
                            if (_key.currentState!.validate() &&
                                !context.read<LoadingBloc>().state.isLoading) {
                              final repo = getIt<ExpenseRepository>();

                              try {
                                context.read<LoadingBloc>().add(StartLoading());
                                final res = widget.expense != null
                                    ? await repo.updateExpense(widget.expense!.copyWith(
                                        description:
                                            _descriptionController.text.trim(),
                                        totalAmount: num.tryParse(_amountController.text) ??
                                            0,
                                        date: DateFormat('MMM d yyyy')
                                            .parse(_dateController.text),
                                        time: _timeController.text,
                                        expenseHead:
                                            ExpenseHeadModel(id: _head?.key)))
                                    : await repo.createExpense(ExpenseModel(
                                        id: _id.value,
                                        description:
                                            _descriptionController.text.trim(),
                                        totalAmount: num.tryParse(_amountController.text) ??
                                            0,
                                        date: DateFormat('MMM d yyyy')
                                            .parse(_dateController.text),
                                        time: _timeController.text,
                                        expenseHead: ExpenseHeadModel(id: _head?.key)));
                                if (mounted && context.mounted) {
                                  context
                                      .read<LoadingBloc>()
                                      .add(StopLoading());
                                  context
                                      .read<AllExpensesBloc>()
                                      .add(LoadAllExpensesEvent());
                                  getIt<NavigationHelper>().pop(context);
                                  utils.showSuccessFlushBar(context,
                                      message: res.message ??
                                          (widget.expense != null
                                              ? "Promotion updated Successfully"
                                              : "Promotion Added Successfully"));
                                }
                              } catch (e, stackTrace) {
                                if (context.mounted) {
                                  debugPrint(stackTrace.toString());
                                  debugPrint(e.toString());
                                  context
                                      .read<LoadingBloc>()
                                      .add(StopLoading());
                                  utils.showErrorFlushBar(context,
                                      message: e.toString());
                                }
                              }
                            }
                          },
                          text: 'Save Expense',
                        ),
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
