import 'package:flutter_test_project/instances/art.dart';
import 'package:hive_flutter/adapters.dart';

abstract class IArtStorageService {
  Future<List<Art>> getArtsFromStorage();
}

class ArtStorageService implements IArtStorageService {
  @override
  Future<List<Art>> getArtsFromStorage() async {
    await Hive.initFlutter();

    final artBox = await Hive.openBox<Art>('art');

    return artBox.values.toList();
  }
}
