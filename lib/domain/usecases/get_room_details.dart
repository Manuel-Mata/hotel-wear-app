import '../entities/entities.dart';
import '../repositories/repositories.dart';

/// Caso de uso: Obtener el detalle de una habitación por su ID.
class GetRoomDetails {
  final RoomsRepository _repository;

  const GetRoomDetails(this._repository);

  Future<Room> call(String id) {
    return _repository.getRoomById(id);
  }
}
