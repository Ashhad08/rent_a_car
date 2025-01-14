import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/expense/all_expenses_bloc/all_expenses_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';
import '../add_update_expenses_view/add_update_expenses_view.dart';
import 'widgets/expense_card.dart';

class AllExpensesView extends StatelessWidget {
  const AllExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: getIt<Utils>().popIcon(context),
        title: const Text('All Expenses'),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              fixedSize: Size(24, 24),
              iconSize: 22,
              backgroundColor: getIt<AppColors>().kPrimaryColor,
              foregroundColor: context.colorScheme.secondary,
            ),
            onPressed: () {
              getIt<NavigationHelper>().push(context, AddUpdateExpensesView());
            },
            icon: Icon(Icons.add),
          ).space(height: 32, width: 32),
          20.width,
        ],
      ),
      body: GradientBody(
        child: BlocBuilder<AllExpensesBloc, AllExpensesState>(
          builder: (context, state) {
            if (state is AllExpensesLoaded) {
              return RefreshIndicator.adaptive(
                  onRefresh: () async => context.read<AllExpensesBloc>().add(
                        LoadAllExpensesEvent(),
                      ),
                  child: ListView.separated(
                    padding: EdgeInsets.all(20),
                    separatorBuilder: (context, index) => 14.height,
                    itemCount: state.expenses.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ExpenseCard(
                        expense: state.expenses[index], showIcons: true),
                  ));
            }
            if (state is AllExpensesError) {
              return Center(
                child: Text(state.error,
                    style: TextStyle(color: context.colorScheme.onPrimary)),
              );
            }

            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }
}
