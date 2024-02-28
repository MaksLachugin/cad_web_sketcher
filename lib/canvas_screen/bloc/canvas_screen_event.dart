part of 'canvas_screen_bloc.dart';

abstract class CanvasScreenEvent extends Equatable {
  const CanvasScreenEvent();
}

class ReDrawCanvasScreen extends CanvasScreenEvent {
  const ReDrawCanvasScreen(
    this.canvasModel,
  );

  final CanvasModel canvasModel;

  @override
  List<Object?> get props => [canvasModel];
}
