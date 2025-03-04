// lib/features/booking/presentation/view/booking_history_view.dart
import 'package:ClickEt/common/widgets/ticket_item.dart';
import 'package:ClickEt/features/bookings/presentation/view_model/booking_history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ClickEt/app/di/di.dart';

class BookingHistoryView extends StatelessWidget {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<BookingBloc>()..add(FetchBookingHistoryEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
        ),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            } else if (state.bookings.isEmpty) {
              return const Center(child: Text('No bookings found'));
            } else {
              return ListView.builder(
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.bookings[index];
                  return TicketItem(booking: booking);
                },
              );
            }
          },
        ),
      ),
    );
  }
}