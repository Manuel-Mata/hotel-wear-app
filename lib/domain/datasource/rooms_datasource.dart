import '../entities/entities.dart';

/// Contrato abstracto para la fuente de datos de habitaciones.
/// Tanto el datasource remoto (API) como el local (Hive) deben implementar esta interfaz.
abstract class RoomsDataSource {
  /// Obtiene la lista completa de habitaciones.
  /// Puede recibir filtros opcionales de [status] y [type].
  Future<List<Room>> getRooms({RoomStatus? status, RoomType? type});

  /// Obtiene el detalle de una habitación por su [id].
  /// Lanza excepción si no se encuentra.
  Future<Room> getRoomById(String id);

  /// Actualiza el estado de una habitación.
  Future<Room> updateRoomStatus(String id, RoomStatus newStatus);
}
