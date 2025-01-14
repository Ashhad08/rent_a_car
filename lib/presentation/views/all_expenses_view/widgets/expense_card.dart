import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/expense/all_expenses_bloc/all_expenses_bloc.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/extensions.dart';
import '../../../../data/models/expense/expense_model.dart';
import '../../../../domain/implementations/expense/expense_repository.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../../../utils/utils.dart';
import '../../../elements/custom_elevated_button.dart';
import '../../add_update_expenses_view/add_update_expenses_view.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(
      {super.key, required this.expense, required this.showIcons});

  final ExpenseModel expense;
  final bool showIcons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      decoration: BoxDecoration(
          color: getIt<AppColors>().kCardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colorScheme.outline)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.expenseHead?.expenseHeadName ?? "",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onPrimary),
                  ),
                  Text(
                    expense.description ?? '',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: context.colorScheme.onPrimary),
                  ),
                  Text(
                    expense.date != null
                        ? DateFormat('MMM d yyyy').format(expense.date!)
                        : "",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: context.colorScheme.onPrimary),
                  )
                ],
              )),
              if (showIcons) ...[
                10.width,
                Column(
                  children: [
                    IconButton.outlined(
                        onPressed: () {
                          getIt<NavigationHelper>().push(
                              context,
                              AddUpdateExpensesView(
                                expense: expense,
                              ));
                        },
                        padding: EdgeInsets.zero,
                        style: IconButton.styleFrom(
                            side: BorderSide(
                                color: getIt<AppColors>().kPrimaryColor)),
                        icon: Image.asset(
                          Assets.iconsEdit2,
                          color: getIt<AppColors>().kPrimaryColor,
                          height: 18,
                          width: 18,
                        )).space(height: 30, width: 30),
                    12.height,
                    IconButton.outlined(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (c) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  side: BorderSide(
                                    color: getIt<AppColors>().kPrimaryColor,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 27),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      Assets.iconsDelete,
                                      height: 34,
                                      color: getIt<AppColors>().kPrimaryColor,
                                      width: 34,
                                    ),
                                    24.height,
                                    Text(
                                      'Are you sure you want to delete this Expense?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: context.colorScheme.onPrimary),
                                    ),
                                    24.height,
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Navigator.of(c).pop();
                                            },
                                            style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                              color: getIt<AppColors>()
                                                  .kPrimaryColor,
                                            )),
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: getIt<AppColors>()
                                                    .kPrimaryColor,
                                              ),
                                            ),
                                          ).space(height: 48),
                                        ),
                                        Expanded(
                                          child: CustomElevatedButton(
                                            onPressed: () async {
                                              final utils = getIt<Utils>();
                                              Navigator.of(c).pop();
                                              final repo =
                                                  getIt<ExpenseRepository>();

                                              try {
                                                final res =
                                                    await repo.deleteExpense(
                                                        expense.id.toString());
                                                if (context.mounted) {
                                                  context
                                                      .read<AllExpensesBloc>()
                                                      .add(
                                                          LoadAllExpensesEvent());
                                                  utils.showSuccessFlushBar(
                                                    context,
                                                    message: res.message ??
                                                        "Expense Deleted Successfully",
                                                  );
                                                }
                                              } catch (e, stackTrace) {
                                                if (context.mounted) {
                                                  debugPrint(
                                                      stackTrace.toString());
                                                  debugPrint(e.toString());
                                                  utils.showErrorFlushBar(
                                                      context,
                                                      message: e.toString());
                                                }
                                              }
                                            },
                                            text: 'Delete',
                                          ).space(height: 48),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        style: IconButton.styleFrom(
                            side: BorderSide(
                                color: getIt<AppColors>().kPrimaryColor)),
                        padding: EdgeInsets.zero,
                        icon: Image.asset(
                          Assets.iconsDelete,
                          color: getIt<AppColors>().kPrimaryColor,
                          height: 18,
                          width: 18,
                        )).space(height: 30, width: 30),
                  ],
                ),
              ]
            ],
          ),
          14.height,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.colorScheme.outline),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: getIt<AppColors>().kPrimaryColor,
                  ),
                ),
                Text(
                  (expense.totalAmount ?? 0).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: getIt<AppColors>().kPrimaryColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
