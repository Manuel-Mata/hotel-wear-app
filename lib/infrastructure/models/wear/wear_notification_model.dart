import 'package:hotel_wear_app/domain/entities/wear/wear_notification.dart';

/// Modelo para notificaciones del wearable
class WearNotificationModel {
  final String id;
  final String type;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final Map<String, dynamic>? metadata;

  WearNotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.metadata,
  });

  factory WearNotificationModel.fromJson(Map<String, dynamic> json) {
    return WearNotificationModel(
      id: json['id'] ?? '',
      type: json['type'] ?? 'taskAssigned',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      isRead: json['isRead'] ?? json['is_read'] ?? false,
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'metadata': metadata,
    };
  }

  WearNotification toEntity() {
    return WearNotification(
      id: id,
      type: _parseNotificationType(type),
      title: title,
      message: message,
      timestamp: timestamp,
      isRead: isRead,
      metadata: metadata,
    );
  }

  static WearNotificationType _parseNotificationType(String type) {
    return WearNotificationType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => WearNotificationType.taskAssigned,
    );
  }
}