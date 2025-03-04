import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUploadDialog extends StatefulWidget {
  final Function(File?) onImagePicked;

  const ImageUploadDialog({super.key, required this.onImagePicked});

  @override
  State<ImageUploadDialog> createState() => _ImageUploadDialogState();
}

class _ImageUploadDialogState extends State<ImageUploadDialog> {
  File? _img;

  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
        widget.onImagePicked(_img);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Image Source'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_img != null)
            CircleAvatar(
              radius: 50,
              backgroundImage: FileImage(_img!),
            ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              checkCameraPermission();
              _browseImage(ImageSource.camera);
            },
            icon: const Icon(Icons.camera),
            label: const Text('Camera'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              _browseImage(ImageSource.gallery);
            },
            icon: const Icon(Icons.image),
            label: const Text('Gallery'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _img != null
              ? () {
                  Navigator.pop(context);
                }
              : null,
          child: const Text('Done'),
        ),
      ],
    );
  }
}