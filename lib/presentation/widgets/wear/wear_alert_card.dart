import 'package:flutter/material.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_alert.dart';

class WearAlertCard extends StatelessWidget {
  final WearAlert alert;
  final VoidCallback onAcknowledge;

  const WearAlertCard({
    Key? key,
    required this.alert,
    required this.onAcknowledge,
  }) : super(key: key);

  Color _getSeverityColor() {
    return switch (alert.severity) {
      AlertSeverity.low => Colors.blue,
      AlertSeverity.medium => Colors.yellow,
      AlertSeverity.high => Colors.orange,
      AlertSeverity.critical => Colors.red,
    };
  }

  Icon _getSeverityIcon() {
    return switch (alert.severity) {
      AlertSeverity.low => const Icon(Icons.info),
      AlertSeverity.medium => const Icon(Icons.warning),
      AlertSeverity.high => const Icon(Icons.error_outline),
      AlertSeverity.critical => const Icon(Icons.emergency),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: _getSeverityColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _getSeverityColor(), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    _getSeverityIcon(),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        alert.message,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: _getSeverityColor(),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getSeverityColor(),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  alert.severity.label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Hace ${DateTime.now().difference(alert.createdAt).inMinutes} min',
            style: TextStyle(fontSize: 11, color: Colors.grey[400]),
          ),
          if (!alert.isAcknowledged) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onAcknowledge,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getSeverityColor(),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: const Text(
                  'Reconocer',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '✓ Reconocida',
                style: TextStyle(fontSize: 11, color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }
}