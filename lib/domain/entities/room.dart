/// Tipos de habitación disponibles en el hotel
enum RoomType {
  single,
  double,
  suite,
  deluxe,
  penthouse;

  String get label => switch (this) {
        RoomType.single => 'Sencilla',
        RoomType.double => 'Doble',
        RoomType.suite => 'Suite',
        RoomType.deluxe => 'Deluxe',
        RoomType.penthouse => 'Penthouse',
      };
}

/// Estados posibles de una habitación
enum RoomStatus {
  available,
  occupied,
  maintenance,
  reserved;

  String get label => switch (this) {
        RoomStatus.available => 'Disponible',
        RoomStatus.occupied => 'Ocupada',
        RoomStatus.maintenance => 'Mantenimiento',
        RoomStatus.reserved => 'Reservada',
      };
}

/// Entidad Room — representa una habitación del hotel en la capa de dominio.
/// Es independiente de la fuente de datos (API o local).
class Room {
  final String id;
  final int roomNumber;
  final RoomType roomType;
  final RoomStatus status;
  final double pricePerNight;
  final String description;
  final List<String> images;
  final int capacity;
  final List<String> amenities;

  const Room({
    required this.id,
    required this.roomNumber,
    required this.roomType,
    required this.status,
    required this.pricePerNight,
    required this.description,
    required this.images,
    required this.capacity,
    required this.amenities,
  });

  /// Retorna true si la habitación está disponible para reservar
  bool get isAvailable => status == RoomStatus.available;

  /// Crea una copia de la entidad con los campos modificados
  Room copyWith({
    String? id,
    int? roomNumber,
    RoomType? roomType,
    RoomStatus? status,
    double? pricePerNight,
    String? description,
    List<String>? images,
    int? capacity,
    List<String>? amenities,
  }) {
    return Room(
      id: id ?? this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      roomType: roomType ?? this.roomType,
      status: status ?? this.status,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      description: description ?? this.description,
      images: images ?? this.images,
      capacity: capacity ?? this.capacity,
      amenities: amenities ?? this.amenities,
    );
  }

  @override
  String toString() =>
      'Room(id: $id, number: $roomNumber, type: ${roomType.label}, status: ${status.label})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Room && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
