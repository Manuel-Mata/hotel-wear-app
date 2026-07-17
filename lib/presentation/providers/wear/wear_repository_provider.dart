import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_wear_app/config/services/wear_communication_service.dart';
import 'package:hotel_wear_app/infrastructure/datasource/wear/wear_datasource_impl.dart';
import 'package:hotel_wear_app/infrastructure/repositories/wear/wear_repository_impl.dart';
import 'package:hotel_wear_app/domain/repositories/wear/wear_repository.dart';
import 'package:hotel_wear_app/infrastructure/services/wear_communication_service_impl.dart';

/// Provider de WearCommunicationService (singleton)
final wearCommunicationServiceProvider = Provider<WearCommunicationService>((ref) {
  // TODO: Reemplazar con implementación real cuando WebSocket esté listo
  return WearCommunicationServiceImpl();
});

/// Provider de WearRepository (singleton)
final wearRepositoryProvider = Provider<WearRepository>((ref) {
  final communicationService = ref.watch(wearCommunicationServiceProvider);
  final datasource = WearDatasourceImpl();
  
  return WearRepositoryImpl(
    datasource: datasource,
    communicationService: communicationService,
  );
});