import 'package:ClickEt/common/widgets/button.dart';
import 'package:ClickEt/common/widgets/dropdown.dart';
import 'package:ClickEt/features/screenig/presentation/view_model/screening_bloc.dart';
import 'package:ClickEt/features/seats/presentation/view/seat_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:intl/intl.dart';

class MovieDetailsView extends StatelessWidget {
  final MovieEntity movie;

  const MovieDetailsView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ScreeningBloc>()..add(FetchScreeningsEvent(movie.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(movie.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Movie Poster
              Image.network(
                movie.posterLargeUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              // Movie Details
              Row(
                children: [
                  Image.network(
                    movie.posterSmallUrl,
                    width: 80,
                    height: 120,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Category: ${movie.category}'),
                        Text('Release: ${movie.releaseDate}'),
                        Text('Duration: ${movie.durationMin} minutes'),
                        Text('Language: ${movie.language}'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                'Description:\n${movie.description}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // Dynamic Date Tiles
              BlocBuilder<ScreeningBloc, ScreeningState>(
                builder: (context, state) {
                  if (state.isLoading) return const CircularProgressIndicator();
                  if (state.errorMessage != null) {
                    return Text('Error: ${state.errorMessage}');
                  }
                  if (state.screenings.isEmpty) {
                    return const Text('No screenings available');
                  }

                  final dates = state.screenings
                      .map(
                          (s) => s.startTime.toLocal().toString().split(' ')[0])
                      .toSet()
                      .toList();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dates.map((date) {
                          // Parse the date to display as "26 Feb"
                          final parsedDate = DateTime.parse(date);
                          final day = parsedDate.day.toString();
                          final month = DateFormat('MMM').format(parsedDate);

                          final isSelected = state.selectedDate == date;

                          return GestureDetector(
                            onTap: () => context
                                .read<ScreeningBloc>()
                                .add(SelectDateEvent(date)),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 24),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    day,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    month,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // Theatre Dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<ScreeningBloc, ScreeningState>(
                  builder: (context, state) {
                    if (state.selectedDate == null) {
                      return const SizedBox.shrink();
                    }

                    final theatres = state.screenings
                        .where((s) =>
                            s.startTime.toLocal().toString().split(' ')[0] ==
                            state.selectedDate)
                        .map((s) => s.theatreName)
                        .toSet()
                        .toList();

                    if (theatres.isEmpty) {
                      return const Text('No theatres available for this date');
                    }

                    return CustomDropdown<String>(
                      hint: 'Select your Theatre',
                      value: state.selectedTheatre,
                      items: theatres
                          .map(
                              (t) => DropdownMenuItem(value: t, child: Text(t)))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<ScreeningBloc>()
                              .add(SelectTheatreEvent(value));
                        }
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Time Selection (Horizontal Buttons)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<ScreeningBloc, ScreeningState>(
                  builder: (context, state) {
                    if (state.selectedDate == null ||
                        state.selectedTheatre == null) {
                      return const SizedBox.shrink();
                    }

                    final times = state.screenings
                        .where((s) =>
                            s.startTime.toLocal().toString().split(' ')[0] ==
                                state.selectedDate &&
                            s.theatreName == state.selectedTheatre)
                        .map((s) {
                          final time = s.startTime.toLocal();
                          final hour = time.hour;
                          final minute = time.minute.toString().padLeft(2, '0');
                          return {
                            'value': s.startTime
                                .toLocal()
                                .toString()
                                .split(' ')[1]
                                .substring(0, 5),
                            'display':
                                '$hour:$minute ${hour < 12 ? "AM" : "PM"}'
                          };
                        })
                        .toSet()
                        .toList();

                    if (times.isEmpty) return const SizedBox.shrink();

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: times.map((timeInfo) {
                          final isSelected =
                              state.selectedTime == timeInfo['value'];

                          return GestureDetector(
                            onTap: () => context
                                .read<ScreeningBloc>()
                                .add(SelectTimeEvent(timeInfo['value']!)),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                              ),
                              child: Text(
                                timeInfo['display']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Hall Dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<ScreeningBloc, ScreeningState>(
                  builder: (context, state) {
                    if (state.selectedDate == null ||
                        state.selectedTheatre == null ||
                        state.selectedTime == null) {
                      return const SizedBox.shrink();
                    }

                    final halls = state.screenings
                        .where((s) =>
                            s.startTime.toLocal().toString().split(' ')[0] ==
                                state.selectedDate &&
                            s.theatreName == state.selectedTheatre &&
                            s.startTime
                                    .toLocal()
                                    .toString()
                                    .split(' ')[1]
                                    .substring(0, 5) ==
                                state.selectedTime)
                        .map((s) => s.hallName)
                        .toSet()
                        .toList();

                    if (halls.isEmpty) return const SizedBox.shrink();

                    return CustomDropdown<String>(
                      hint: 'Select your Hall',
                      value: state.selectedHall,
                      items: halls
                          .map(
                              (h) => DropdownMenuItem(value: h, child: Text(h)))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<ScreeningBloc>()
                              .add(SelectHallEvent(value));
                        }
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Book Button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: BlocBuilder<ScreeningBloc, ScreeningState>(
                  builder: (context, state) {
                    final isEnabled = state.selectedDate != null &&
                        state.selectedTheatre != null &&
                        state.selectedTime != null &&
                        state.selectedHall != null;

                    if (!isEnabled) return const SizedBox.shrink();

                    final selectedScreening = state.screenings.firstWhere(
                      (s) =>
                          s.startTime.toLocal().toString().split(' ')[0] ==
                              state.selectedDate &&
                          s.theatreName == state.selectedTheatre &&
                          s.startTime
                                  .toLocal()
                                  .toString()
                                  .split(' ')[1]
                                  .substring(0, 5) ==
                              state.selectedTime &&
                          s.hallName == state.selectedHall,
                      orElse: () =>
                          throw Exception('No matching screening found'),
                    );

                    return Button(
                      iconBeforeText: true,
                      icon: const Icon(Icons.book_online_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeatSelectionView(
                                screeningId: selectedScreening.screeningId),
                          ),
                        );
                      },
                      text: "Book Seat",
                      width: 'full',
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
