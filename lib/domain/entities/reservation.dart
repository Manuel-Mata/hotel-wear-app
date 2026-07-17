/// Estados posibles de una reservación
enum ReservationStatus {
  pending,
  confirmed,
  checkedIn,
  checkedOut,
  cancelled;

  String get label => switch (this) {
        ReservationStatus.pending => 'Pendiente',
        ReservationStatus.confirmed => 'Confirmada',
        ReservationStatus.checkedIn => 'Check-in realizado',
        ReservationStatus.checkedOut => 'Check-out realizado',
        ReservationStatus.cancelled => 'Cancelada',
      };
}

/// Entidad Reservation — representa una reservación en la capa de dominio.
/// Es independiente de la fuente de datos (API o local).
class Reservation {
  final String id;
  final String roomId;
  final String guestId;
  final String guestName;
  final DateTime checkIn;
  final DateTime checkOut;
  final ReservationStatus status;
  final double total;
  final DateTime createdAt;
  final String? notes;

  const Reservation({
    required this.id,
    required this.roomId,
    required this.guestId,
    required this.guestName,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.total,
    required this.createdAt,
    this.notes,
  });

  /// Número de noches de la reservación
  int get nights => checkOut.difference(checkIn).inDays;

  /// Retorna true si la reservación está activa (pendiente o confirmada)
  bool get isActive =>
      status == ReservationStatus.pending ||
      status == ReservationStatus.confirmed;

  /// Retorna true si ya se realizó check-in
  bool get hasCheckedIn => status == ReservationStatus.checkedIn;

  /// Crea una copia de la entidad con los campos modificados
  Reservation copyWith({
    String? id,
    String? roomId,
    String? guestId,
    String? guestName,
    DateTime? checkIn,
    DateTime? checkOut,
    ReservationStatus? status,
    double? total,
    DateTime? createdAt,
    String? notes,
  }) {
    return Reservation(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      guestId: guestId ?? this.guestId,
      guestName: guestName ?? this.guestName,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      status: status ?? this.status,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() =>
      'Reservation(id: $id, guest: $guestName, status: ${status.label}, nights: $nights)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Reservation && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
