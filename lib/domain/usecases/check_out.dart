import '../entities/entities.dart';
import '../repositories/repositories.dart';

/// Caso de uso: Realizar el check-out de una reservación.
/// Cambia el estado de la reservación a [ReservationStatus.checkedOut].
class CheckOut {
  final ReservationsRepository _repository;

  const CheckOut(this._repository);

  Future<Reservation> call(String reservationId) {
    return _repository.checkOut(reservationId);
  }
}
