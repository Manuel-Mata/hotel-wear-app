import '../entities/entities.dart';
import '../repositories/repositories.dart';

/// Caso de uso: Obtener la lista de reservaciones.
/// Puede filtrar por [status] y/o [guestId].
class GetReservations {
  final ReservationsRepository _repository;

  const GetReservations(this._repository);

  Future<List<Reservation>> call({
    ReservationStatus? status,
    String? guestId,
  }) {
    return _repository.getReservations(status: status, guestId: guestId);
  }
}
