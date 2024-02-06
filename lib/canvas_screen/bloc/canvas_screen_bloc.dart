import 'dart:async';

import 'package:cad_web_sketcher/repo/models/figure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'canvas_screen_event.dart';
part 'canvas_screen_state.dart';

class CanvasScreenBloc extends Bloc<CanvasScreenEvent, CanvasScreenState> {
  CanvasScreenBloc() : super(CanvasScreenInitial()) {
    on<ReDrawCanvasScreen>(_draw);
  }

  Future<void> _draw(
    ReDrawCanvasScreen event,
    Emitter<CanvasScreenState> emit,
  ) async {
    try {
      emit(CanvasScreenDrawed(event.figure));
    } catch (e, st) {
      emit(CanvasScreenLoadingFailure(event.figure, exception: e));
      GetIt.I<Talker>().handle(e, st);
    } finally {}
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
