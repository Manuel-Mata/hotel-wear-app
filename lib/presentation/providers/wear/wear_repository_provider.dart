import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_wear_app/config/services/wear_communication_service.dart';
import 'package:hotel_wear_app/infrastructure/datasource/wear/wear_datasource_impl.dart';
import 'package:hotel_wear_app/infrastructure/repositories/wear/wear_repository_impl.dart';
import 'package:hotel_wear_app/domain/repositories/wear/wear_repository.dart';
import 'package:hotel_wear_app/infrastructure/services/wear_communication_service_impl.dart';
import 'package:hotel_wear_app/domain/datasource/wear/wear_datasource.dart';

/// Provider de WearCommunicationService (singleton)
final wearCommunicationServiceProvider = Provider<WearCommunicationService>((ref) {
  return WearCommunicationServiceImpl();
});

/// Provider del datasource local con mocks
final wearDatasourceProvider = Provider<WearDatasource>((ref) {
  return WearDatasourceImpl();
});

/// Provider de WearRepository usando Mock Data local (sin Firebase ni conectividad)
final wearRepositoryProvider = Provider<WearRepository>((ref) {
  return WearRepositoryImpl(
    datasource: ref.watch(wearDatasourceProvider),
    communicationService: ref.watch(wearCommunicationServiceProvider),
  );
});