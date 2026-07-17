import 'package:flutter/material.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_task.dart';

class WearTaskCard extends StatelessWidget {
  final WearTask task;
  final VoidCallback onTap;
  final VoidCallback? onAccept;

  const WearTaskCard({
    Key? key,
    required this.task,
    required this.onTap,
    this.onAccept,
  }) : super(key: key);

  Color _getStatusColor() {
    return switch (task.status) {
      WearTaskStatus.pending => Colors.orange,
      WearTaskStatus.inProgress => Colors.blue,
      WearTaskStatus.completed => Colors.green,
      WearTaskStatus.cancelled => Colors.grey,
    };
  }

  Icon _getTaskIcon() {
    return switch (task.taskType) {
      WearTaskType.cleaning => const Icon(Icons.cleaning_services),
      WearTaskType.maintenance => const Icon(Icons.build),
      WearTaskType.inspection => const Icon(Icons.assignment_ind),
      WearTaskType.delivery => const Icon(Icons.local_shipping),
      WearTaskType.guest_request => const Icon(Icons.person),
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _getStatusColor(), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _getTaskIcon(),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Habitación ${task.roomNumber}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            task.taskType.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task.status.label,
                    style: TextStyle(
                      fontSize: 10,
                      color: _getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Colors.grey[300]),
            ),
            if (task.status == WearTaskStatus.pending && onAccept != null) ...[
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}