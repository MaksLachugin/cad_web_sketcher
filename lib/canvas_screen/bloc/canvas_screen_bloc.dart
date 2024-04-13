import 'dart:async';

import 'package:cad_web_sketcher/repo/sketcher_models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
part 'canvas_screen_event.dart';
part 'canvas_screen_state.dart';

class CanvasScreenBloc extends Bloc<CanvasScreenEvent, CanvasScreenState> {
  CanvasScreenBloc() : super(CanvasScreenInitial()) {
    on<ReDrawCanvasScreen>(_draw);
    on<RotateCanvasScreen>(_rotate);
    on<CallNewFigureCanvasScreen>(_newFigure);
    on<SelectLineCanvasScreen>(_selectLine);
  }

  Future<void> _selectLine(
    SelectLineCanvasScreen event,
    Emitter<CanvasScreenState> emit,
  ) async {
    try {
      var cm = state.canvasModel;
      emit(CanvasScreenDrawed(cm, event.selectedLine));
    } catch (e, st) {
      emit(CanvasScreenLoadingFailure(state.canvasModel, state.selectedLine,
          exception: e));
      GetIt.I<Talker>().handle(e, st);
    } finally {}
  }

  Future<void> _newFigure(
    CallNewFigureCanvasScreen event,
    Emitter<CanvasScreenState> emit,
  ) async {
    try {
      emit(CanvasScreenDrawed(CanvasModel.fromEnum(event.value), 0));
    } catch (e, st) {
      emit(CanvasScreenLoadingFailure(state.canvasModel, state.selectedLine,
          exception: e));
      GetIt.I<Talker>().handle(e, st);
    } finally {}
  }

  Future<void> _rotate(
    RotateCanvasScreen event,
    Emitter<CanvasScreenState> emit,
  ) async {
    try {
      var cm = state.canvasModel;
      cm.angle += event.angle;
      emit(CanvasScreenDrawed(cm, state.selectedLine));
    } catch (e, st) {
      emit(CanvasScreenLoadingFailure(state.canvasModel, state.selectedLine,
          exception: e));
      GetIt.I<Talker>().handle(e, st);
    } finally {}
  }

  Future<void> _draw(
    ReDrawCanvasScreen event,
    Emitter<CanvasScreenState> emit,
  ) async {
    try {
      emit(CanvasScreenDrawed(event.canvasModel, state.selectedLine));
    } catch (e, st) {
      emit(CanvasScreenLoadingFailure(event.canvasModel, state.selectedLine,
          exception: e));
      GetIt.I<Talker>().handle(e, st);
    } finally {}
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
