import '../entities/entities.dart';
import '../repositories/repositories.dart';

/// Caso de uso: Realizar el check-in de una reservación.
/// Cambia el estado de la reservación a [ReservationStatus.checkedIn].
class CheckIn {
  final ReservationsRepository _repository;

  const CheckIn(this._repository);

  Future<Reservation> call(String reservationId) {
    return _repository.checkIn(reservationId);
  }
}
