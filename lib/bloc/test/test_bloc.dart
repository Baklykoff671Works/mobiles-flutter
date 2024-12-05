
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/bloc/test/test_event.dart';
import 'package:flutter_test_project/bloc/test/test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<DeleteMovies>((event, emit) {
      print('hello');
      emit(TestDeleted());
    });
    on<UpdateMovies>((event, emit) {
      print('hello1');
      emit(TestUpdated());
    });
  }
}