import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_task.dart';
import 'package:hotel_wear_app/presentation/providers/wear/wear_repository_provider.dart';

/// Provider de todas las tareas
final wearTasksProvider = FutureProvider<List<WearTask>>((ref) async {
  final repository = ref.watch(wearRepositoryProvider);
  return repository.getTasks();
});

/// Provider de tareas pendientes
final wearPendingTasksProvider = FutureProvider<List<WearTask>>((ref) async {
  final repository = ref.watch(wearRepositoryProvider);
  return repository.getTasksByStatus(WearTaskStatus.pending);
});

/// Provider de tareas en progreso
final wearInProgressTasksProvider = FutureProvider<List<WearTask>>((ref) async {
  final repository = ref.watch(wearRepositoryProvider);
  return repository.getTasksByStatus(WearTaskStatus.inProgress);
});

/// Provider de tareas completadas
final wearCompletedTasksProvider = FutureProvider<List<WearTask>>((ref) async {
  final repository = ref.watch(wearRepositoryProvider);
  return repository.getTasksByStatus(WearTaskStatus.completed);
});

/// Provider para obtener una tarea específica
final wearTaskByIdProvider = FutureProvider.family<WearTask?, String>((ref, taskId) async {
  final repository = ref.watch(wearRepositoryProvider);
  return repository.getTaskById(taskId);
});

/// Provider para manejar aceptación de tarea
final acceptWearTaskProvider = FutureProvider.family<void, String>((ref, taskId) async {
  final repository = ref.watch(wearRepositoryProvider);
  await repository.acceptTask(taskId);
  // Refrescar lista de tareas
  ref.refresh(wearTasksProvider);
});

/// Provider para iniciar tarea
final startWearTaskProvider = FutureProvider.family<void, String>((ref, taskId) async {
  final repository = ref.watch(wearRepositoryProvider);
  await repository.startTask(taskId);
  ref.refresh(wearTasksProvider);
});

/// Provider para completar tarea
final completeWearTaskProvider = FutureProvider.family<void, (String, String?)>((ref, params) async {
  final (taskId, notes) = params;
  final repository = ref.watch(wearRepositoryProvider);
  await repository.completeTask(taskId, notes: notes);
  ref.refresh(wearTasksProvider);
});

/// Provider para cancelar tarea
final cancelWearTaskProvider = FutureProvider.family<void, String>((ref, taskId) async {
  final repository = ref.watch(wearRepositoryProvider);
  await repository.cancelTask(taskId);
  ref.refresh(wearTasksProvider);
});