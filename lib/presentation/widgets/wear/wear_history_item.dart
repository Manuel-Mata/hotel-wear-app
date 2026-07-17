import 'package:flutter/material.dart';
import 'package:hotel_wear_app/domain/entities/wear/wear_task.dart';

class WearHistoryItem extends StatelessWidget {
  final WearTask task;

  const WearHistoryItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  Color _getStatusColor() {
    return switch (task.status) {
      WearTaskStatus.completed => Colors.green,
      WearTaskStatus.cancelled => Colors.red,
      _ => Colors.grey,
    };
  }

  Duration get _duration {
    if (task.completedAt != null) {
      return task.completedAt!.difference(task.createdAt);
    }
    return Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Creada: ${task.createdAt.hour}:${task.createdAt.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 10, color: Colors.grey[500]),
              ),
              if (task.completedAt != null)
                Text(
                  'Duración: ${_duration.inMinutes} min',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}