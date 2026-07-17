import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_task.dart';
import 'package:hotel_wear_app/presentation/providers/wear/wear_providers.dart';
import 'package:hotel_wear_app/presentation/screens/wear/wear_confirmation_screen.dart';

/// Pantalla de detalle de una tarea del wearable.
/// Permite ver toda la información de la tarea y navegar
/// a la pantalla de confirmación para completarla.
class WearTaskDetailScreen extends ConsumerWidget {
  static const String routeName = '/wear-task-detail';

  final String taskId;

  const WearTaskDetailScreen({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(wearTasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Tarea'),
        elevation: 0,
      ),
      body: tasksAsync.when(
        data: (tasks) {
          final matching = tasks.where((t) => t.id == taskId).toList();

          if (matching.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green, size: 64),
                  SizedBox(height: 16),
                  Text(
                    'Tarea completada',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          final task = matching.first;
          return _TaskDetailBody(task: task);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Text(
            'Error al cargar la tarea',
            style: TextStyle(color: Colors.red[300]),
          ),
        ),
      ),
    );
  }
}

class _TaskDetailBody extends StatelessWidget {
  final WearTask task;

  const _TaskDetailBody({required this.task});

  Color _priorityColor(int priority) {
    if (priority >= 4) return Colors.red;
    if (priority == 3) return Colors.orange;
    return Colors.green;
  }

  IconData _taskIcon(WearTaskType type) {
    switch (type) {
      case WearTaskType.cleaning:
        return Icons.cleaning_services;
      case WearTaskType.maintenance:
        return Icons.build;
      case WearTaskType.inspection:
        return Icons.search;
      case WearTaskType.delivery:
        return Icons.local_shipping;
      case WearTaskType.guest_request:
        return Icons.room_service;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Encabezado
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _taskIcon(task.taskType),
                          color: Colors.blue,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Habitación ${task.roomNumber}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              task.taskType.label,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Indicador de prioridad
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _priorityColor(task.priority).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _priorityColor(task.priority),
                          ),
                        ),
                        child: Text(
                          'P${task.priority}',
                          style: TextStyle(
                            color: _priorityColor(task.priority),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Descripción
                Text(
                  'Descripción',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    task.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 20),

                // Tiempo transcurrido
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.timer_outlined, color: Colors.grey[400], size: 20),
                            const SizedBox(height: 4),
                            Text(
                              '${task.elapsedTime.inMinutes} min',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Transcurrido',
                              style: TextStyle(color: Colors.grey[500], fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.flag_outlined, color: Colors.grey[400], size: 20),
                            const SizedBox(height: 4),
                            Text(
                              task.status.label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Estado',
                              style: TextStyle(color: Colors.grey[500], fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Botón Completar (navega a confirmation)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.check_circle_outline, size: 20),
                    label: const Text(
                      'Completar tarea',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WearConfirmationScreen(task: task),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Botón Volver
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Volver',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
