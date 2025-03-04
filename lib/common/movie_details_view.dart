import 'package:ClickEt/features/screenig/presentation/view_model/screening_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';

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
                  if (state.errorMessage != null)
                    return Text('Error: ${state.errorMessage}');
                  if (state.screenings.isEmpty)
                    return const Text('No screenings available');

                  final dates = state.screenings
                      .map(
                          (s) => s.startTime.toLocal().toString().split(' ')[0])
                      .toSet()
                      .toList();
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: dates
                          .map((date) => GestureDetector(
                                onTap: () => context
                                    .read<ScreeningBloc>()
                                    .add(SelectDateEvent(date)),
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  padding: const EdgeInsets.all(8),
                                  color: state.selectedDate == date
                                      ? Colors.blue
                                      : Colors.grey,
                                  child: Text(date),
                                ),
                              ))
                          .toList(),
                    ),
                  );
                },
              ),

              // Theatre Dropdown
              BlocBuilder<ScreeningBloc, ScreeningState>(
                builder: (context, state) {
                  if (state.selectedDate == null)
                    return const Text('Please select a date');
                  final theatres = state.screenings
                      .where((s) =>
                          s.startTime.toLocal().toString().split(' ')[0] ==
                          state.selectedDate)
                      .map((s) => s.theatreName)
                      .toSet()
                      .toList();
                  if (theatres.isEmpty)
                    return const Text('No theatres available for this date');

                  return DropdownButton<String>(
                    hint: const Text('Select Theatre'),
                    value: state.selectedTheatre,
                    items: theatres
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null)
                        context
                            .read<ScreeningBloc>()
                            .add(SelectTheatreEvent(value));
                    },
                  );
                },
              ),

              // Time Dropdown
              BlocBuilder<ScreeningBloc, ScreeningState>(
                builder: (context, state) {
                  if (state.selectedDate == null ||
                      state.selectedTheatre == null) {
                    return const Text('Please select a date and theatre');
                  }
                  final times = state.screenings
                      .where((s) =>
                          s.startTime.toLocal().toString().split(' ')[0] ==
                              state.selectedDate &&
                          s.theatreName == state.selectedTheatre)
                      .map((s) => s.startTime
                          .toLocal()
                          .toString()
                          .split(' ')[1]
                          .substring(0, 5))
                      .toSet()
                      .toList();
                  if (times.isEmpty) return const Text('No times available');

                  return DropdownButton<String>(
                    hint: const Text('Select Time'),
                    value: state.selectedTime,
                    items: times
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null)
                        context
                            .read<ScreeningBloc>()
                            .add(SelectTimeEvent(value));
                    },
                  );
                },
              ),

              // Hall Dropdown
              BlocBuilder<ScreeningBloc, ScreeningState>(
                builder: (context, state) {
                  if (state.selectedDate == null ||
                      state.selectedTheatre == null ||
                      state.selectedTime == null) {
                    return const Text(
                        'Please select a date, theatre, and time');
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
                  if (halls.isEmpty) return const Text('No halls available');

                  return DropdownButton<String>(
                    hint: const Text('Select Hall'),
                    value: state.selectedHall,
                    items: halls
                        .map((h) => DropdownMenuItem(value: h, child: Text(h)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null)
                        context
                            .read<ScreeningBloc>()
                            .add(SelectHallEvent(value));
                    },
                  );
                },
              ),

              // Book Button (optional, based on full selection)
              BlocBuilder<ScreeningBloc, ScreeningState>(
                builder: (context, state) {
                  final isEnabled = state.selectedDate != null &&
                      state.selectedTheatre != null &&
                      state.selectedTime != null &&
                      state.selectedHall != null;
                  return ElevatedButton(
                    onPressed: isEnabled ? () => print('Book seat!') : null,
                    child: const Text('Book Seat'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
