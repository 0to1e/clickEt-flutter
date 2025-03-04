import 'package:ClickEt/app/constants/api_endpoints.dart';
import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/common/widgets/booking_widgets_dialog.dart';
import 'package:ClickEt/features/bookings/domain/entity/booking_entity.dart';
import 'package:ClickEt/features/bookings/presentation/view_model/booking_history_bloc.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';
import 'package:ClickEt/core/network/api_service.dart';

class TicketItem extends StatefulWidget {
  final BookingEntity booking;

  const TicketItem({super.key, required this.booking});

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _downloadTicket(BuildContext context, String bookingId) async {
    final bloc = context.read<BookingBloc>();
    bloc.add(DownloadTicketEvent(bookingId));

    final state = await bloc.stream.firstWhere(
      (state) => !state.isDownloading,
    );

    if (state.downloadError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: ${state.downloadError}')),
      );
      return;
    }

    // Request storage permission
    PermissionStatus status;
    if (await Permission.storage.isDenied) {
      status = await Permission.storage.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Storage permission is required. Please enable it in settings.',
            ),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: openAppSettings,
            ),
          ),
        );
        return;
      }
    }

    // Use application documents directory
    final dir = await getApplicationDocumentsDirectory();
    final downloadsDirPath = dir.path;
    final directory = Directory(downloadsDirPath);
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }

    final filePath = '$downloadsDirPath/ticket_$bookingId.pdf';
    final url = '${ApiEndpoints.downloadTicket}/$bookingId';

    try {
      final dio = getIt<ApiService>().dio;
      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Download completed!'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () => OpenFile.open(filePath).then((result) {
                if (result.type != ResultType.done) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Failed to open file: ${result.message}')),
                  );
                }
              }),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Download failed with status: ${response.statusCode}')),
        );
      }
    } catch (e) {
      debugPrint('Download error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateTime = DateTime.parse(widget.booking.screeningDate);
    final formattedDate = DateFormat('EEE, MMM d').format(dateTime);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);

    return Container(
      // Keep a little vertical/horizontal spacing
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      // The Stack is used to place notches and grooves around the main container
      child: Stack(
        clipBehavior: Clip.none, // allow notches to render outside
        children: [
          // Main ticket body
          Container(
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.primary, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Movie poster
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      widget.booking.posterUrl,
                      width: 90,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Middle details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 12,
                      bottom: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Movie name
                        Text(
                          widget.booking.movieName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: theme.colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Date & Time
                        Text(
                          'Date: $formattedDate',
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Time: $formattedTime',
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        // Link-style buttons
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => BookingDetailsDialog(
                                      booking: widget.booking),
                                );
                              },
                              child: Text(
                                'View details',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => _downloadTicket(
                                  context, widget.booking.bookingId),
                              child: Text(
                                'Download Ticket',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Right side - Confirmation code
                Container(
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: theme.colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        widget.booking.confirmationCode,
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 16,
                          color: theme.colorScheme.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Four circular notches: top-left, bottom-left, top-right, bottom-right
          Positioned(
            top: -10,
            left: -10,
            child: _buildNotch(context),
          ),
          Positioned(
            bottom: -10,
            left: -10,
            child: _buildNotch(context),
          ),
          Positioned(
            top: -10,
            right: -10,
            child: _buildNotch(context),
          ),
          Positioned(
            bottom: -10,
            right: -10,
            child: _buildNotch(context),
          ),

          // Left grooves
          Positioned(
            left: -8,
            top: 20,
            bottom: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(8, (_) => _buildGroove(context)),
            ),
          ),
          // Right grooves
          Positioned(
            right: -8,
            top: 20,
            bottom: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(8, (_) => _buildGroove(context)),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single circular notch.
  Widget _buildNotch(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amber[50], // match the ticket color
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
      ),
    );
  }

  /// Builds a small "groove" dash on the sides of the ticket.
  Widget _buildGroove(BuildContext context) {
    return Container(
      width: 14,
      height: 5,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
