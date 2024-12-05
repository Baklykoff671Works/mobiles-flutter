import 'package:flutter_test_project/instances/art.dart';

abstract class ArtDataState {}

class ArtDataInitial extends ArtDataState {}

class ArtDataLoading extends ArtDataState {}

class ArtDataLoaded extends ArtDataState {
  final List<Art> arts;

  ArtDataLoaded(this.arts);
}
