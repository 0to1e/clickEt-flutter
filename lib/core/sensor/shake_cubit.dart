import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:ClickEt/core/navigation/global_navigator.dart';

class ShakeCubit extends Cubit<bool> {
  final MovieBloc movieBloc;
  StreamSubscription? _accelerometerSubscription;

  ShakeCubit({required this.movieBloc}) : super(false);

  void startListening() {
    if (state) return;
    emit(true);

    _accelerometerSubscription?.cancel(); // Prevent duplicate listeners

    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      double acceleration = event.x.abs() + event.y.abs() + event.z.abs();

      if (acceleration > 20) { // Shake threshold
        debugPrint("🔥 Shake Detected: Refreshing Movies List");
        _refreshMoviesList();
      }
    });
  }

  void stopListening() {
    _accelerometerSubscription?.cancel();
    emit(false);
  }

  void _refreshMoviesList() {
    // Wait for the UI frame to ensure context is available
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final context = globalNavigatorKey.currentContext;

      if (context != null && context.mounted) {
        debugPrint("✅ Showing Snackbar: Refreshing movies...");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Refreshing movies...")),
        );

        movieBloc.add(const RefreshMoviesEvent());
      } else {
        debugPrint("❌ ERROR: Context is still null, skipping Snackbar.");
      }
    });
  }
  
  @override
  Future<void> close() {
    _accelerometerSubscription?.cancel();
    return super.close();
  }
}
