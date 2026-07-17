import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_wear_app/presentation/providers/wear/wear_providers.dart';
import 'package:hotel_wear_app/presentation/widgets/wear/wear_task_card.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_task.dart';

class WearDashboardScreen extends ConsumerWidget {
  static const String routeName = '/wear-dashboard';
  static const String routePath = '/wear-dashboard';
  

  const WearDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingTasksAsync = ref.watch(wearPendingTasksProvider);
    final inProgressTasksAsync = ref.watch(wearInProgressTasksProvider);
    final connectionStatusAsync = ref.watch(wearCommunicationServiceProvider).connectionStatus;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Control'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: connectionStatusAsync,
                builder: (context, status, _) {
                  return Tooltip(
                    message: status.toString(),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: status.name == 'connected' ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tareas en progreso
            Text(
              'En Progreso',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            inProgressTasksAsync.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Sin tareas en progreso',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return Column(
                  children: tasks
                      .map((task) => WearTaskCard(
                            task: task,
                            onTap: () {
                              // TODO: Navegar a detalle
                            },
                          ))
                      .toList(),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (err, st) => Text('Error: $err'),
            ),
            const SizedBox(height: 24),

            // Tareas pendientes
            Text(
              'Pendientes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            pendingTasksAsync.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Sin tareas pendientes',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return Column(
                  children: tasks
                      .map((task) => WearTaskCard(
                            task: task,
                            onTap: () {
                              // TODO: Navegar a detalle
                            },
                            onAccept: () {
                              // TODO: Aceptar tarea
                              ref.read(acceptWearTaskProvider(task.id));
                            },
                          ))
                      .toList(),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (err, st) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }
}