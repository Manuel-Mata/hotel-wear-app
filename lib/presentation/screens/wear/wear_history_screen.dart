import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_wear_app/presentation/providers/wear/wear_providers.dart';
import 'package:hotel_wear_app/presentation/widgets/wear/wear_history_item.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_task.dart';

class WearHistoryScreen extends ConsumerWidget {
  static const String routeName = '/wear-history';

  const WearHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(wearTasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        elevation: 0,
      ),
      body: tasksAsync.when(
        data: (tasks) {
          // Filtrar tareas completadas y canceladas
          final history = tasks
              .where((t) =>
                  t.status == WearTaskStatus.completed ||
                  t.status == WearTaskStatus.cancelled)
              .toList();

          if (history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sin historial',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Las tareas completadas aparecerán aquí',
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                ],
              ),
            );
          }

          // Ordenar por fecha más reciente primero
          history.sort((a, b) => b.createdAt.compareTo(a.createdAt));

          // Agrupar por fecha
          final grouped = <String, List<WearTask>>{};
          for (final task in history) {
            final dateKey = '${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year}';
            grouped.putIfAbsent(dateKey, () => []).add(task);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final entry in grouped.entries) ...[
                  Text(
                    entry.key,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: entry.value
                        .map((task) => WearHistoryItem(task: task))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Error: $err')),
      ),
    );
  }
}