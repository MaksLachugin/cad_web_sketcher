import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'canvas_screen_event.dart';
part 'canvas_screen_state.dart';

class CanvasScreenBloc extends Bloc<CanvasScreenEvent, CanvasScreenState> {
  CanvasScreenBloc() : super(CanvasScreenInitial()) {
    on<CanvasScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
