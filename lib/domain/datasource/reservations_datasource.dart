import '../entities/entities.dart';

/// Parámetros para crear una nueva reservación
class CreateReservationParams {
  final String roomId;
  final String guestId;
  final String guestName;
  final DateTime checkIn;
  final DateTime checkOut;
  final String? notes;

  const CreateReservationParams({
    required this.roomId,
    required this.guestId,
    required this.guestName,
    required this.checkIn,
    required this.checkOut,
    this.notes,
  });
}

/// Contrato abstracto para la fuente de datos de reservaciones.
/// Tanto el datasource remoto (API) como el local (Hive) deben implementar esta interfaz.
abstract class ReservationsDataSource {
  /// Obtiene la lista de reservaciones.
  /// Puede filtrar por [status] o por [guestId].
  Future<List<Reservation>> getReservations({
    ReservationStatus? status,
    String? guestId,
  });

  /// Obtiene el detalle de una reservación por su [id].
  Future<Reservation> getReservationById(String id);

  /// Crea una nueva reservación con los [params] proporcionados.
  Future<Reservation> createReservation(CreateReservationParams params);

  /// Realiza el check-in de una reservación existente.
  Future<Reservation> checkIn(String reservationId);

  /// Realiza el check-out de una reservación existente.
  Future<Reservation> checkOut(String reservationId);

  /// Cancela una reservación existente.
  Future<Reservation> cancelReservation(String reservationId);
}
