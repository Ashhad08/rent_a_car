import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/booking/pending_bookings_bloc/pending_bookings_bloc.dart';
import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../utils/utils.dart';
import '../../elements/gradient_body.dart';
import 'widgets/booking_card.dart';

class RentalRequestsView extends StatelessWidget {
  const RentalRequestsView({super.key});

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
              title: const Text('Rental Requests'),
            ),
            body: GradientBody(
              child: BlocBuilder<PendingBookingsBloc, PendingBookingsState>(
                builder: (context, state) {
                  if (state is PendingBookingsError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: TextStyle(color: context.colorScheme.onPrimary),
                      ),
                    );
                  } else if (state is PendingBookingsLoaded) {
                    return RefreshIndicator(
                      onRefresh: () async => context
                          .read<PendingBookingsBloc>()
                          .add(LoadPendingBookingsEvent()),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => 14.height,
                        itemCount: state.bookings.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.all(20),
                        itemBuilder: (context, index) => BookingCard(
                          booking: state.bookings[index],
                          showActions: true,
                          showEditIcon: false,
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
