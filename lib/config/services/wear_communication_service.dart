import 'package:flutter/foundation.dart';

/// Estados de conexión del wearable
enum WearConnectionStatus {
  connected,
  disconnected,
  reconnecting;
}

/// Interfaz base para la comunicación entre móvil y wearable
abstract class WearCommunicationService {
  /// Observable de estado de conexión
  ValueNotifier<WearConnectionStatus> get connectionStatus;

  /// Inicializa el servicio
  Future<void> initialize();

  /// Envía una tarea al wearable
  Future<void> sendTask({
    required String taskId,
    required int roomNumber,
    required String taskType,
    required String description,
    required int priority,
  });

  /// Acepta una tarea en el wearable
  Future<void> acceptTask(String taskId);

  /// Inicia una tarea en el wearable
  Future<void> startTask(String taskId);

  /// Completa una tarea en el wearable
  Future<void> completeTask({
    required String taskId,
    String? notes,
  });

  /// Cancela una tarea
  Future<void> cancelTask(String taskId);

  /// Recibe actualizaciones de estado desde el wearable
  Stream<Map<String, dynamic>> receiveUpdates();

  /// Envía notificación al wearable
  Future<void> sendNotification({
    required String title,
    required String message,
    required String type,
    Map<String, dynamic>? metadata,
  });

  /// Obtiene el estado actual del wearable
  Future<Map<String, dynamic>> getWearStatus();

  /// Desconecta el servicio
  Future<void> disconnect();
}