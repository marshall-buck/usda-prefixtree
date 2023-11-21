import 'package:mocktail/mocktail.dart';
import 'package:usda_db_creation/file_loader_service.dart';

class MockFileLoaderService extends Mock implements FileLoaderService {}

late final MockFileLoaderService mockFileLoaderService;
// ignore_for_file: non_constant_identifier_names
tear_down() {
  reset(mockFileLoaderService);
}

set_up_all() {
  mockFileLoaderService = MockFileLoaderService();
}
