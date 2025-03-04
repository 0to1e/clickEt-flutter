import 'dart:io';

import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/common/widgets/button.dart';
import 'package:ClickEt/features/auth/presentation/view/login_view.dart';
import 'package:ClickEt/features/auth/presentation/view_model/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(FetchUserEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoggedOut || state is ProfileDeleted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
              if (state is ProfileDeleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User deleted successfully')),
                );
              }
            } else if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                final user = state.user;
                // Handle null cases for user fields
                final displayFullName =
                    user.fullName.isNotEmpty ? user.fullName : 'No Name';
                final displayUserName =
                    user.userName.isNotEmpty ? user.userName : 'No Username';
                final displayEmail =
                    user.email.isNotEmpty ? user.email : 'No Email';

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () => _showImagePickerDialog(context),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: user.profileURL != null &&
                                        user.profileURL!.isNotEmpty
                                    ? NetworkImage(user.profileURL!)
                                        as ImageProvider
                                    : null,
                                child: user.profileURL == null ||
                                        (user.profileURL != null &&
                                            user.profileURL!.isEmpty)
                                    ? Text(
                                        _getInitials(user.fullName),
                                        style: const TextStyle(fontSize: 40),
                                      )
                                    : null,
                              ),
                              const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.edit,
                                    size: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(displayFullName,
                          style: Theme.of(context).textTheme.headlineLarge),
                      Text(displayUserName,
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text(displayEmail,
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 40),
                      Button(
                        text: 'Log Out',
                        onPressed: () {
                          context.read<ProfileBloc>().add(LogoutEvent());
                        },
                      ),
                      const SizedBox(height: 20),
                      Button(
                        text: 'Delete Account',
                        backgroundColor: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Account'),
                              content: const Text(
                                  'Are you sure you want to delete your account? This action cannot be undone.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context
                                        .read<ProfileBloc>()
                                        .add(DeleteAccountEvent());
                                  },
                                  child: const Text('Delete',
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'ClickEt ClickEt inc. 2025 © Designed by Rohan',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showImagePickerDialog(BuildContext context) async {
    final picker = ImagePicker();
    ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text('Gallery'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (source != null) {
      try {
        final pickedFile = await picker.pickImage(source: source);
        if (pickedFile != null) {
          final file = File(pickedFile.path);
          context.read<ProfileBloc>().add(UpdateProfilePictureEvent(file));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  String _getInitials(String fullName) {
    final names = fullName.trim().split(' ');
    if (names.isEmpty) return '';
    if (names.length == 1) return names[0][0].toUpperCase();
    return (names[0][0] + names.last[0]).toUpperCase();
  }
}
