import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';
import 'package:ClickEt/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IAuthRepository authRepository;

  ProfileBloc({required this.authRepository}) : super(ProfileLoading()) {
    on<FetchUserEvent>(_onFetchUser);
    on<UpdateProfilePictureEvent>(_onUpdateProfilePicture);
    on<LogoutEvent>(_onLogout);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  Future<void> _onFetchUser(
      FetchUserEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await authRepository.getUserStatus();
    result.fold(
      (failure) {
        debugPrint("Fetch failed: ${failure.message}");
        emit(ProfileError(failure.message));
      },
      (user) => emit(ProfileLoaded(user)),
    );
  }

  Future<void> _onUpdateProfilePicture(
      UpdateProfilePictureEvent event, Emitter<ProfileState> emit) async {
    debugPrint("Starting profile picture update");
    emit(ProfileLoading());
    final result = await authRepository.uploadProfilePicture(event.image);
    result.fold(
      (failure) {
        emit(ProfileError(failure.message));
      },
      (uploadedUrl) {
        if (state is ProfileLoaded) {
          final currentUser = (state as ProfileLoaded).user;
          final updatedUser = currentUser.copyWith(profileURL: uploadedUrl);
          emit(ProfileLoaded(updatedUser));
        } else {
          add(FetchUserEvent());
        }
      },
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    final result = await authRepository.logout();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(ProfileLoggedOut()),
    );
  }

  Future<void> _onDeleteAccount(
      DeleteAccountEvent event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final user = (state as ProfileLoaded).user;
      final result = await authRepository.deleteUser(user.userName);
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (_) => emit(ProfileDeleted()),
      );
    }
  }
}
