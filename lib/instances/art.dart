
import 'package:hive/hive.dart';

part 'art.g.dart';

@HiveType(typeId: 1)
class Art {
  @HiveField(0)
  final String artName;

  @HiveField(1)
  final String urlImg;

  Art({required this.artName, required this.urlImg});

  factory Art.fromJson(Map<String, dynamic> json) {
    return Art(
      artName: json['name'] as String,
      urlImg: json['url'] as String,
    );
  }
}
