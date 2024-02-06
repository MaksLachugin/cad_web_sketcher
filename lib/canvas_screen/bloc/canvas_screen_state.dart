part of 'canvas_screen_bloc.dart';

abstract class CanvasScreenState extends Equatable {
  final Figure figure;

  const CanvasScreenState(this.figure);
}

class CanvasScreenInitial extends CanvasScreenState {
  CanvasScreenInitial() : super(genFig());

  @override
  List<Object> get props => [];
}

class CanvasScreenDrawed extends CanvasScreenState {
  const CanvasScreenDrawed(super.figure);

  @override
  List<Object?> get props => [figure];
}

class CanvasScreenLoadingFailure extends CanvasScreenState {
  const CanvasScreenLoadingFailure(
    super.figure, {
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [figure, exception];
}
