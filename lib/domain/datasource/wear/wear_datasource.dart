import 'package:hotel_wear_app/domain/entities/wear/wear_task.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_notification.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_alert.dart';

/// Contrato para obtener datos de wearable
abstract class WearDatasource {
  /// Obtiene todas las tareas
  Future<List<WearTask>> getTasks();

  /// Obtiene una tarea por ID
  Future<WearTask?> getTaskById(String taskId);

  /// Obtiene tareas por estado
  Future<List<WearTask>> getTasksByStatus(WearTaskStatus status);

  /// Obtiene todas las notificaciones
  Future<List<WearNotification>> getNotifications();

  /// Obtiene notificaciones no leídas
  Future<List<WearNotification>> getUnreadNotifications();

  /// Obtiene todas las alertas
  Future<List<WearAlert>> getAlerts();

  /// Obtiene alertas no reconocidas
  Future<List<WearAlert>> getUnacknowledgedAlerts();

  /// Actualiza estado de una tarea
  Future<void> updateTaskStatus(String taskId, WearTaskStatus status);

  /// Marca notificación como leída
  Future<void> markNotificationAsRead(String notificationId);

  /// Guarda una nueva tarea localmente
  Future<void> saveTaskLocally(WearTask task);

  /// Limpia caché local
  Future<void> clearCache();
}