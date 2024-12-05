import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_test_project/bloc/art_bloc/art_data_event.dart';
import 'package:flutter_test_project/bloc/art_bloc/art_data_state.dart';
import 'package:flutter_test_project/service/movie/art_service.dart';

class ArtDataBloc extends Bloc<ArtDataEvent, ArtDataState> {
  ArtDataBloc(this.artService) : super(ArtDataInitial()) {
    on<LoadArtData>((event, emit) async {
      emit(ArtDataLoading());
      final arts = await artService.loadArtList();
      emit(ArtDataLoaded(arts));
    });
  }

  final ArtService artService;
}
