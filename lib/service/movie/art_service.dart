import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test_project/instances/art.dart';
import 'package:flutter_test_project/service/movie/art_storage_service.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

abstract class IArtService {
  Future<List<Art>> loadArtList();
}

class ArtService implements IArtService {
  final IArtStorageService artStorageService = ArtStorageService();

  @override
  Future<List<Art>> loadArtList() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(ArtAdapter());
      }
      return artStorageService.getArtsFromStorage();
    } else {
      final response = await http.get(Uri.parse('http://10.0.2.2:5050/arts'));
      final List<dynamic> jsonData = jsonDecode(response.body) as List;
      final List<Art> artList = jsonData
          .map(
            (e) => Art.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return artList;
    }
  }
}
