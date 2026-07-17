import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_wear_app/presentation/providers/wear/wear_providers.dart';
import 'package:hotel_wear_app/presentation/widgets/wear/wear_alert_card.dart';

class WearAlertsScreen extends ConsumerWidget {
  static const String routeName = '/wear-alerts';

  const WearAlertsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(wearAlertsProvider);
    final unacknowledgedAsync = ref.watch(wearUnacknowledgedAlertsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alertas'),
        elevation: 0,
      ),
      body: alertsAsync.when(
        data: (alerts) {
          if (alerts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 48,
                    color: Colors.green[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sin alertas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Todo está bajo control',
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                ],
              ),
            );
          }

          // Separar por reconocidas y no reconocidas
          final unacknowledged =
              alerts.where((a) => !a.isAcknowledged).toList();
          final acknowledged = alerts.where((a) => a.isAcknowledged).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (unacknowledged.isNotEmpty) ...[
                  Text(
                    'Por Reconocer (${unacknowledged.length})',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: unacknowledged
                        .map((alert) => WearAlertCard(
                              alert: alert,
                              onAcknowledge: () {
                                ref.read(acknowledgeWearAlertProvider(alert.id));
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
                if (acknowledged.isNotEmpty) ...[
                  Text(
                    'Reconocidas (${acknowledged.length})',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: acknowledged
                        .map((alert) => WearAlertCard(
                              alert: alert,
                              onAcknowledge: () {},
                            ))
                        .toList(),
                  ),
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