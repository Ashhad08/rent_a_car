import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/customer/all_customers/all_customers_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../navigation/navigation_helper.dart';
import '../../elements/app_text_field.dart';
import '../../elements/gradient_body.dart';
import '../customer_details_view/customer_details_view.dart';

class AllCustomersView extends StatelessWidget {
  const AllCustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('All Customers'),
      ),
      body: GradientBody(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              15.height,
              AppTextField(
                controller: TextEditingController(),
                textInputAction: TextInputAction.search,
                hintText: 'Search',
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  size: 22,
                ),
              ),
              10.height,
              Expanded(child: BlocBuilder<AllCustomersBloc, AllCustomersState>(
                builder: (context, state) {
                  if (state is AllCustomersLoaded) {
                    return RefreshIndicator.adaptive(
                      onRefresh: () async =>
                          context.read<AllCustomersBloc>().add(
                                LoadAllCustomersEvent(),
                              ),
                      child: ListView.separated(
                        padding: EdgeInsets.only(bottom: 20),
                        separatorBuilder: (context, index) => 14.height,
                        itemCount: state.customers.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final customer = state.customers[index];
                          return Material(
                            color: Colors.transparent,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: customer.profileImage == null
                                    ? null
                                    : NetworkImage(customer.profileImage!),
                              ),
                              onTap: () {
                                getIt<NavigationHelper>()
                                    .push(context, CustomerDetailsView());
                              },
                              style: ListTileStyle.list,
                              tileColor: context.colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: BorderSide(
                                      color: context.colorScheme.outline
                                          .withOp(0.5))),
                              title: Text(
                                customer.name ?? "",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              trailing: Icon(
                                Icons.adaptive.arrow_forward,
                                color: context.colorScheme.outline,
                              ),
                              subtitle: Text(
                                customer.mobileNumber ?? "",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: context.theme.listTileTheme
                                        .subtitleTextStyle?.color),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  if (state is AllCustomersError) {
                    return Center(
                      child: Text(state.error),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              )),
              83.height,
            ],
          ),
        ),
      ),
    );
  }
}
