import 'package:ClickEt/features/seats/domain/entity/seat_entity.dart';
import 'package:ClickEt/features/seats/presentation/view_model/seat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClickEt/app/di/di.dart';

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
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<SeatBloc, SeatState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.red));
            }
            if (state.errorMessage.isNotEmpty) {
              return Center(
                  child: Text(state.errorMessage,
                      style: const TextStyle(color: Colors.white)));
            }
            if (state.seatLayout == null) {
              return const Center(
                  child: Text('No seat layout available',
                      style: TextStyle(color: Colors.white)));
            }

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  // Cinema Screen Banner
                  Container(
                    color: Colors.red,
                    height: 50,
                    width: double.infinity,
                    child: const Center(
                      child: Text('Cinema Screen',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  // Scrollable Seat Grid
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
                  // Theater Details, Selected Seats, and Actions
                  _buildTheaterDetailsAndActions(context, state),
                ],
              ),
            );
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
        border: Border.all(color: Colors.white),
      ),
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
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
                        decoration: BoxDecoration(
                          color: _getSeatColor(status),
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            '$seatNumber',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  });

                  // Add gap between sections (except after the last one)
                  if (sectionIndex < seatGrid.length - 1) {
                    return Row(children: [
                      ...seats,
                      const SizedBox(width: 30), // 20px gap
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
        return 'available'; // Fallback
    }
  }

  Color _getSeatColor(String status) {
    switch (status) {
      case 'available':
        return Colors.grey;
      case 'hold':
        return Colors.yellow;
      case 'reserved':
        return Colors.red;
      case 'selected':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Colors.grey, 'Available'),
        const SizedBox(width: 10),
        _legendItem(Colors.yellow, 'Hold'),
        const SizedBox(width: 10),
        _legendItem(Colors.red, 'Reserved'),
        const SizedBox(width: 10),
        _legendItem(Colors.green, 'Selected'),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildTheaterDetailsAndActions(BuildContext context, SeatState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Theater and Screening Details
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                'Theatre Name, Screen Name',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Date: 20 Nov', style: TextStyle(color: Colors.white)),
          const Text('Time: 15:05', style: TextStyle(color: Colors.white)),
          if (state.selectedSeats.isNotEmpty)
            Text(
              'Seats: ${state.selectedSeats.join(', ')}',
              style: const TextStyle(color: Colors.white),
            ),
          const SizedBox(height: 16),
          // Total Price
          const Text(
            'Total Price',
            style: TextStyle(
                color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Rs. 370.000',
            style: TextStyle(
                color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Children (2 years old or above) are required to purchase ticket',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          // Action Buttons
          if (state.bookingStep == 'select' && state.selectedSeats.isNotEmpty)
            ElevatedButton(
              onPressed: () =>
                  context.read<SeatBloc>().add(const HoldSeatsEvent()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Hold Selected Seats',
                  style: TextStyle(color: Colors.white)),
            ),
          if (state.bookingStep == 'hold')
            Column(
              children: [
                ElevatedButton(
                  onPressed: () =>
                      context.read<SeatBloc>().add(const ConfirmBookingEvent()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Pay now',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () =>
                      context.read<SeatBloc>().add(const ReleaseHoldEvent()),
                  child: const Text('Release Hold',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
