import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClickEt/common/widgets/button.dart';
import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/features/seats/presentation/view_model/seat_bloc.dart';
import 'package:ClickEt/features/seats/domain/entity/seat_entity.dart';

class SeatSelectionView extends StatelessWidget {
  final String screeningId;

  const SeatSelectionView({super.key, required this.screeningId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SeatBloc>()..add(FetchSeatLayoutEvent(screeningId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose Seat'),
        ),
        body: BlocBuilder<SeatBloc, SeatState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage.isNotEmpty) {
              return Center(child: Text(state.errorMessage));
            }
            if (state.seatLayout == null) {
              return const Center(child: Text('No seat layout available'));
            }
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  // Cinema Screen Banner
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                      height: 50,
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          'Cinema Screen',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // Scrollable Seat Grid and Legend
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildSeatGrid(context, state),
                          const SizedBox(height: 16),
                          _buildLegend(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // The green container is now pinned at the bottom using bottomNavigationBar.
        bottomNavigationBar: BlocBuilder<SeatBloc, SeatState>(
          builder: (context, state) {
            // Optionally, show nothing if no seat layout is available.
            if (state.seatLayout == null) return const SizedBox.shrink();
            return _buildTheaterDetailsAndActions(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildSeatGrid(BuildContext context, SeatState state) {
    final seatGrid = state.seatLayout!.seatGrid;
    final maxRows = seatGrid.fold<int>(
        0,
        (max, section) =>
            section.rows.length > max ? section.rows.length : max);

    // Calculate starting seat number for each section
    List<int> sectionStartNumbers = [];
    int cumulativeSeats = 0;
    for (var section in seatGrid) {
      sectionStartNumbers.add(cumulativeSeats + 1);
      if (section.rows.isNotEmpty) {
        cumulativeSeats += section.rows[0].length;
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.primary.withAlpha(35),
      ),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: List.generate(maxRows, (rowIndex) {
            return Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    String.fromCharCode(65 + rowIndex),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ...List.generate(seatGrid.length, (sectionIndex) {
                  final section = seatGrid[sectionIndex];
                  if (rowIndex >= section.rows.length) {
                    return const SizedBox(width: 0);
                  }
                  final row = section.rows[rowIndex];
                  final startNumber = sectionStartNumbers[sectionIndex];
                  final seats = List<Widget>.generate(row.length, (colIndex) {
                    final seatNumber = startNumber + colIndex;
                    final seatId =
                        '${String.fromCharCode(65 + rowIndex)}$seatNumber';
                    final seat = row[colIndex];
                    final isSelected = state.selectedSeats.contains(seatId);
                    final status = _getSeatStatus(seat, isSelected);
                    return GestureDetector(
                      onTap: () =>
                          context.read<SeatBloc>().add(SelectSeatEvent(seatId)),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        width: 30,
                        height: 30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.event_seat,
                              color: _getSeatColor(status),
                              size: 30,
                            ),
                            Text(
                              '$seatNumber',
                              style: TextStyle(
                                color: status == 'selected'
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });

                  // Add gap between sections except after the last one
                  if (sectionIndex < seatGrid.length - 1) {
                    return Row(children: [
                      ...seats,
                      const SizedBox(width: 20),
                    ]);
                  } else {
                    return Row(children: seats);
                  }
                }).expand((widget) => [widget]),
              ],
            );
          }),
        ),
      ),
    );
  }

  String _getSeatStatus(SeatEntity seat, bool isSelected) {
    if (isSelected) return 'selected';
    switch (seat.code) {
      case 'a':
        return 'available';
      case 'h':
        return 'hold';
      case 'r':
        return 'reserved';
      default:
        return 'available';
    }
  }

  Color _getSeatColor(String status) {
    switch (status) {
      case 'available':
        return Colors.grey.shade700;
      case 'hold':
        return Colors.amber;
      case 'reserved':
        return Colors.red;
      case 'selected':
        return Colors.green;
      default:
        return Colors.grey.shade700;
    }
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _legendItem(Icons.event_seat, Colors.grey.shade700, 'Available'),
          const SizedBox(width: 16),
          _legendItem(Icons.event_seat, Colors.amber, 'Hold'),
          const SizedBox(width: 16),
          _legendItem(Icons.event_seat, Colors.red, 'Reserved'),
          const SizedBox(width: 16),
          _legendItem(Icons.event_seat, Colors.green, 'Selected'),
        ],
      ),
    );
  }

  Widget _legendItem(IconData icon, Color color, String label) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }

  // This widget is now used as the bottomNavigationBar.
  Widget _buildTheaterDetailsAndActions(BuildContext context, SeatState state) {
    // Calculate total price based on selected seats.
    final double unitPrice = state.seatLayout?.price ?? 0;
    final int seatCount = state.selectedSeats.length;
    final double totalPrice = unitPrice * seatCount;

    return Container(
      padding: const EdgeInsets.all(16),
      // The container's decoration can be adjusted as needed.
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Theme.of(context).colorScheme.primary.withAlpha(30),
              width: 1),
        ),
        color: Theme.of(context).colorScheme.primary.withAlpha(30),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensure it sizes itself to its content.
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.selectedSeats.isNotEmpty) ...[
            const SizedBox(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.event_seat, color: Colors.green, size: 34),
                    const SizedBox(width: 4),
                    Text(
                      'Selected Seats ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  state.selectedSeats.join(', '),
                  style: const TextStyle(fontSize: 22),
                )
              ],
            ),
          ],
          const SizedBox(height: 16),
          // Total Price Section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withAlpha(40),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.withAlpha(60)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Price per seat is applied',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  'Rs. ${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Action Buttons
          if (state.bookingStep == 'select' && state.selectedSeats.isNotEmpty)
            Button(
              onPressed: () {
                context.read<SeatBloc>().add(const HoldSeatsEvent());
              },
              text: "Hold Selected Seats",
            ),
          if (state.bookingStep == 'hold')
            Column(
              children: [
                Button(
                  onPressed: () {
                    _showPaymentDialog(context);
                  },
                  text: "Proceed to Payment",
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    context.read<SeatBloc>().add(const ReleaseHoldEvent());
                  },
                  style: TextButton.styleFrom(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 50),
                  ),
                  child: const Text(
                    'Release Hold',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          'Payment methods',
        ),
        content: const Text(
          'Please choose your payment method',
        ),
        actions: [
          Button(
            onPressed: () {
              Navigator.pop(context);
              context.read<SeatBloc>().add(const ConfirmBookingEvent());
            },
            text: "Direct Payment",
          ),
          const SizedBox(height: 15),
          Button(
            onPressed: () {
              Navigator.pop(context);
            },
            text: "Khalti",
            backgroundColor: Colors.deepPurpleAccent,
          ),
          const SizedBox(height: 15),
          Button(
            onPressed: () {
              Navigator.pop(context);
            },
            text: "Cancel",
            textColor: Theme.of(context).colorScheme.primary,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withAlpha(15),
          ),
        ],
      ),
    );
  }
}
