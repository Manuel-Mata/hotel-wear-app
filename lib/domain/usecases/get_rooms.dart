import '../entities/entities.dart';
import '../repositories/repositories.dart';

/// Caso de uso: Obtener la lista de habitaciones.
/// Puede filtrar por [status] y/o [type].
class GetRooms {
  final RoomsRepository _repository;

  const GetRooms(this._repository);

  Future<List<Room>> call({RoomStatus? status, RoomType? type}) {
    return _repository.getRooms(status: status, type: type);
  }
}
