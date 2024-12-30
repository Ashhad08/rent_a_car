import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';
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
        leading: getIt<Utils>().popIcon(context),
        title: const Text('All Owners'),
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
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20),
                  separatorBuilder: (context, index) => 14.height,
                  itemCount: 10,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Material(
                    color: Colors.transparent,
                    child: ListTile(
                      onTap: () {
                        getIt<NavigationHelper>()
                            .push(context, CustomerDetailsView());
                      },
                      leading: CircleAvatar(),
                      style: ListTileStyle.list,
                      tileColor: context.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                              color: context.colorScheme.outline.withOp(0.5))),
                      title: Text(
                        'Brooklyn Simmons',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      trailing: Icon(
                        Icons.adaptive.arrow_forward,
                        color: context.colorScheme.outline,
                      ),
                      subtitle: Text(
                        '+92 123456789',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: context
                                .theme.listTileTheme.subtitleTextStyle?.color),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
