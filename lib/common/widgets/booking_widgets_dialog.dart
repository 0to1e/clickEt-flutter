// lib/features/booking/presentation/widget/booking_details_dialog.dart
import 'package:ClickEt/features/bookings/domain/entity/booking_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingDetailsDialog extends StatelessWidget {
  final BookingEntity booking;

  const BookingDetailsDialog({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screeningDate = DateTime.parse(booking.screeningDate);
    final formattedScreeningDate =
        DateFormat('EEE, MMM d, yyyy').format(screeningDate);
    final formattedScreeningTime = DateFormat('hh:mm a').format(screeningDate);
    final createdAt = DateFormat('EEE, MMM d, yyyy at hh:mm a')
        .format(DateTime.parse(booking.createdAt));
    final paidAt = DateFormat('EEE, MMM d, yyyy at hh:mm a')
        .format(DateTime.parse(booking.paidAt));

    return AlertDialog(
      title: Text(booking.movieName),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${booking.status}'),
            Text('Confirmation Code: ${booking.confirmationCode}'),
            Text('Confirmed on: $createdAt'),
            Text('Theatre: ${booking.theatreName}'),
            Text('Hall: ${booking.hallName}'),
            Text('Date: $formattedScreeningDate'),
            Text('Time: $formattedScreeningTime'),
            Text(
              'Seats: ${booking.seats.map((s) => s.seatId).join(', ')}',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
            Text('Payment Method: ${booking.paymentMethod}'),
            Text('Amount: Rs. ${booking.paidAmount}'),
            Text('Paid on: $paidAt'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}