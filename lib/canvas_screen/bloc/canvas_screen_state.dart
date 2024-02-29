part of 'canvas_screen_bloc.dart';

abstract class CanvasScreenState extends Equatable {
  final CanvasModel canvasModel;

  const CanvasScreenState(this.canvasModel);
}

class CanvasScreenInitial extends CanvasScreenState {
  CanvasScreenInitial()
      : super(CanvasModel.fromRoofElement(RoofElements.valleyBottom));

  @override
  List<Object> get props => [];
}

class CanvasScreenDrawed extends CanvasScreenState {
  const CanvasScreenDrawed(super.canvasModel);

  @override
  List<Object?> get props => [canvasModel];
}

class CanvasScreenLoadingFailure extends CanvasScreenState {
  const CanvasScreenLoadingFailure(
    super.canvasModel, {
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [canvasModel, exception];
}
