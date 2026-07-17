import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_wear_app/presentation/providers/wear/wear_providers.dart';
import 'package:hotel_wear_app/presentation/widgets/wear/wear_history_item.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_task.dart';

class WearHistoryScreen extends ConsumerWidget {
  static const String routeName = '/wear-history';

  const WearHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(wearTasksProvider);

    const circularPadding = EdgeInsets.fromLTRB(28, 44, 28, 44);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        minimum: circularPadding,
        child: tasksAsync.when(
          data: (tasks) {
            final history =
                tasks
                    .where(
                      (t) =>
                          t.status == WearTaskStatus.completed ||
                          t.status == WearTaskStatus.cancelled,
                    )
                    .toList()
                  ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

            if (history.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history, size: 36, color: Colors.white24),
                    SizedBox(height: 10),
                    Text(
                      'Sin historial',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Las tareas completadas\naparecerán aquí',
                      style: TextStyle(color: Colors.white38, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            // Agrupar por fecha
            final grouped = <String, List<WearTask>>{};
            for (final task in history) {
              final dateKey =
                  '${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year}';
              grouped.putIfAbsent(dateKey, () => []).add(task);
            }

            return CustomScrollView(
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.history,
                          size: 13,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Historial',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${history.length} tareas',
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                for (final entry in grouped.entries) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 4),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => WearHistoryItem(task: entry.value[i]),
                      childCount: entry.value.length,
                    ),
                  ),
                ],

                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            );
          },
          loading: () => const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          error: (e, _) => Center(
            child: Text(
              'Error',
              style: TextStyle(color: Colors.red[400], fontSize: 11),
            ),
          ),
        ),
      ),
    );
  }
}
