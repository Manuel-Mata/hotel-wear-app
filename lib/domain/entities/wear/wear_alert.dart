/// Severidad de las alertas
enum AlertSeverity {
  low,
  medium,
  high,
  critical;

  String get label => switch (this) {
        AlertSeverity.low => 'Baja',
        AlertSeverity.medium => 'Media',
        AlertSeverity.high => 'Alta',
        AlertSeverity.critical => 'Crítica',
      };
}

/// Entidad WearAlert — alertas específicas del wearable
class WearAlert {
  final String id;
  final String message;
  final AlertSeverity severity;
  final DateTime createdAt;
  final bool isAcknowledged;
  final String? roomId;

  const WearAlert({
    required this.id,
    required this.message,
    required this.severity,
    required this.createdAt,
    this.isAcknowledged = false,
    this.roomId,
  });

  /// Retorna true si la alerta es crítica
  bool get isCritical => severity == AlertSeverity.critical;

  WearAlert copyWith({
    String? id,
    String? message,
    AlertSeverity? severity,
    DateTime? createdAt,
    bool? isAcknowledged,
    String? roomId,
  }) {
    return WearAlert(
      id: id ?? this.id,
      message: message ?? this.message,
      severity: severity ?? this.severity,
      createdAt: createdAt ?? this.createdAt,
      isAcknowledged: isAcknowledged ?? this.isAcknowledged,
      roomId: roomId ?? this.roomId,
    );
  }

  @override
  String toString() =>
      'WearAlert(id: $id, severity: ${severity.label}, acknowledged: $isAcknowledged)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is WearAlert && other.id == id;

  @override
  int get hashCode => id.hashCode;
}