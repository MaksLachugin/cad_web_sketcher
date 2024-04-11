part of 'canvas_screen_bloc.dart';

abstract class CanvasScreenState extends Equatable {
  final CanvasModel canvasModel;
  final int selectedLine;

  const CanvasScreenState(this.canvasModel, this.selectedLine);
}

class CanvasScreenInitial extends CanvasScreenState {
  CanvasScreenInitial()
      : super(CanvasModel.fromEnum(RoofElements.valleyBottom), 0);

  @override
  List<Object> get props => [canvasModel, selectedLine];
}

class CanvasScreenDrawed extends CanvasScreenState {
  const CanvasScreenDrawed(super.canvasModel, super.selectedLine);

  @override
  List<Object?> get props => [canvasModel, selectedLine];
}

class CanvasScreenLoadingFailure extends CanvasScreenState {
  const CanvasScreenLoadingFailure(
    super.canvasModel,
    super.selectedLine, {
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [canvasModel, exception];
}
