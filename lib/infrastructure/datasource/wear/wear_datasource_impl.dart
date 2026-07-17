import 'package:hotel_wear_app/domain/datasource/wear/wear_datasource.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_task.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_notification.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_alert.dart';

/// Implementación del datasource de wearable con datos simulados (Mock)
class WearDatasourceImpl implements WearDatasource {
  
  final List<WearTask> _mockTasks = [
    WearTask(
      id: '1',
      roomId: 'r1',
      roomNumber: 101,
      taskType: WearTaskType.cleaning,
      status: WearTaskStatus.pending,
      description: 'Limpieza general y cambio de toallas.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      priority: 3,
    ),
    WearTask(
      id: '2',
      roomId: 'r2',
      roomNumber: 205,
      taskType: WearTaskType.guest_request,
      status: WearTaskStatus.inProgress,
      description: 'Huésped solicita almohadas extra.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      priority: 5,
    ),
    WearTask(
      id: '3',
      roomId: 'r3',
      roomNumber: 304,
      taskType: WearTaskType.maintenance,
      status: WearTaskStatus.pending,
      description: 'Revisar aire acondicionado, hace ruido.',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      priority: 4,
    ),
  ];

  final List<WearNotification> _mockNotifications = [];
  final List<WearAlert> _mockAlerts = [];

  @override
  Future<List<WearTask>> getTasks() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockTasks;
  }

  @override
  Future<WearTask?> getTaskById(String taskId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockTasks.firstWhere((t) => t.id == taskId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<WearTask>> getTasksByStatus(WearTaskStatus status) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockTasks.where((t) => t.status == status).toList();
  }

  @override
  Future<List<WearNotification>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockNotifications;
  }

  @override
  Future<List<WearNotification>> getUnreadNotifications() async {
    return _mockNotifications.where((n) => !n.isRead).toList();
  }

  @override
  Future<List<WearAlert>> getAlerts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockAlerts;
  }

  @override
  Future<List<WearAlert>> getUnacknowledgedAlerts() async {
    return _mockAlerts.where((a) => !a.isAcknowledged).toList();
  }

  @override
  Future<void> updateTaskStatus(String taskId, WearTaskStatus status) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _mockTasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _mockTasks[index] = _mockTasks[index].copyWith(status: status);
    }
  }

  @override
  Future<void> markNotificationAsRead(String notificationId) async {
    final index = _mockNotifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _mockNotifications[index] = _mockNotifications[index].copyWith(isRead: true);
    }
  }

  @override
  Future<void> saveTaskLocally(WearTask task) async {
    final index = _mockTasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _mockTasks[index] = task;
    } else {
      _mockTasks.add(task);
    }
  }

  @override
  Future<void> clearCache() async {
    // No-op for mock
  }
}
