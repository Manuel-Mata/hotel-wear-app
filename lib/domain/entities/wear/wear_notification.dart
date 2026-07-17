/// Tipos de notificación para el wearable
enum WearNotificationType {
  taskAssigned,
  taskCompleted,
  roomStatusChanged,
  urgentAlert,
  guestRequest;

  String get label => switch (this) {
        WearNotificationType.taskAssigned => 'Tarea Asignada',
        WearNotificationType.taskCompleted => 'Tarea Completada',
        WearNotificationType.roomStatusChanged => 'Habitación Cambió Estado',
        WearNotificationType.urgentAlert => 'Alerta Urgente',
        WearNotificationType.guestRequest => 'Solicitud de Huésped',
      };
}

/// Entidad WearNotification — notificaciones que llegan al wearable
class WearNotification {
  final String id;
  final WearNotificationType type;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final Map<String, dynamic>? metadata; // datos adicionales (taskId, roomId, etc)

  const WearNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.metadata,
  });

  /// Copia con campos modificados
  WearNotification copyWith({
    String? id,
    WearNotificationType? type,
    String? title,
    String? message,
    DateTime? timestamp,
    bool? isRead,
    Map<String, dynamic>? metadata,
  }) {
    return WearNotification(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  String toString() =>
      'WearNotification(id: $id, type: ${type.label}, title: $title)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is WearNotification && other.id == id;

  @override
  int get hashCode => id.hashCode;
}