import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/owner/all_owners/all_owners_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/extensions.dart';
import '../../../navigation/navigation_helper.dart';
import '../../elements/app_text_field.dart';
import '../../elements/gradient_body.dart';
import '../owner_details_view/owner_details_view.dart';

class AllOwnersView extends StatelessWidget {
  const AllOwnersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
              Expanded(child: BlocBuilder<AllOwnersBloc, AllOwnersState>(
                builder: (context, state) {
                  if (state is AllOwnersLoaded) {
                    return RefreshIndicator.adaptive(
                      onRefresh: () async => context.read<AllOwnersBloc>().add(
                            LoadAllOwnersEvent(),
                          ),
                      child: ListView.separated(
                        padding: EdgeInsets.only(bottom: 20),
                        separatorBuilder: (context, index) => 14.height,
                        itemCount: state.owners.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final ownerInfo = state.owners[index].ownerInfo;
                          if (ownerInfo == null) return null;
                          return Material(
                            color: Colors.transparent,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: ownerInfo.ownerImage == null
                                    ? null
                                    : NetworkImage(ownerInfo.ownerImage!),
                              ),
                              onTap: () {
                                getIt<NavigationHelper>().push(
                                    context,
                                    OwnerDetailsView(
                                      owner: state.owners[index],
                                    ));
                              },
                              style: ListTileStyle.list,
                              tileColor: getIt<AppColors>().kCardColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: BorderSide(
                                      color: context.colorScheme.outline)),
                              title: Text(
                                ownerInfo.ownerName ?? "",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: context.colorScheme.onPrimary),
                              ),
                              trailing: Icon(
                                Icons.adaptive.arrow_forward,
                                color: context.colorScheme.onPrimary,
                              ),
                              subtitle: Text(
                                ownerInfo.mobileNumber ?? "",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: context.colorScheme.onPrimary),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  if (state is AllOwnersError) {
                    return Center(
                      child: Text(state.error,
                          style:
                              TextStyle(color: context.colorScheme.onPrimary)),
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
