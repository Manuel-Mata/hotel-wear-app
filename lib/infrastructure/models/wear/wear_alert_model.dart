import 'package:hotel_wear_app/domain/entities/wear/wear_alert.dart';

/// Modelo para alertas del wearable
class WearAlertModel {
  final String id;
  final String message;
  final String severity;
  final DateTime createdAt;
  final bool isAcknowledged;
  final String? roomId;

  WearAlertModel({
    required this.id,
    required this.message,
    required this.severity,
    required this.createdAt,
    this.isAcknowledged = false,
    this.roomId,
  });

  factory WearAlertModel.fromJson(Map<String, dynamic> json) {
    return WearAlertModel(
      id: json['id'] ?? '',
      message: json['message'] ?? '',
      severity: json['severity'] ?? 'medium',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      isAcknowledged: json['isAcknowledged'] ?? json['is_acknowledged'] ?? false,
      roomId: json['roomId'] ?? json['room_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'severity': severity,
      'createdAt': createdAt.toIso8601String(),
      'isAcknowledged': isAcknowledged,
      'roomId': roomId,
    };
  }

  WearAlert toEntity() {
    return WearAlert(
      id: id,
      message: message,
      severity: _parseSeverity(severity),
      createdAt: createdAt,
      isAcknowledged: isAcknowledged,
      roomId: roomId,
    );
  }

  static AlertSeverity _parseSeverity(String severity) {
    return AlertSeverity.values.firstWhere(
      (e) => e.name == severity,
      orElse: () => AlertSeverity.medium,
    );
  }
}