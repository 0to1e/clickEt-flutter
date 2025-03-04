import 'package:equatable/equatable.dart';

class ScreeningEntity extends Equatable {
  final String screeningId;
  final String theatreName;
  final String hallName;
  final DateTime startTime;
  final double finalPrice;
  final String status;

  const ScreeningEntity({
    required this.screeningId,
    required this.theatreName,
    required this.hallName,
    required this.startTime,
    required this.finalPrice,
    required this.status,
  });

  factory ScreeningEntity.fromJson(Map<String, dynamic> json) {
    return ScreeningEntity(
      screeningId: json['_id'] as String,
      theatreName: json['theatreId']['name'] as String,
      hallName: json['hallId']['name'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      finalPrice: (json['finalPrice'] as num).toDouble(),
      status: json['status'] as String,
    );
  }

  @override
  List<Object> get props => [
        screeningId,
        theatreName,
        hallName,
        startTime,
        finalPrice,
        status,
      ];
}
