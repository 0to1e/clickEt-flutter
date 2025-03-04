part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserEvent extends ProfileEvent {}

class UpdateProfilePictureEvent extends ProfileEvent {
  final File image;

  const UpdateProfilePictureEvent(this.image);
}

class LogoutEvent extends ProfileEvent {}

class DeleteAccountEvent extends ProfileEvent {}