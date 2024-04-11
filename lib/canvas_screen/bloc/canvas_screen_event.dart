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

class RotateCanvasScreen extends CanvasScreenEvent {
  const RotateCanvasScreen(
    this.angle,
  );

  final double angle;

  @override
  List<Object?> get props => [angle];
}

class CallNewFigureCanvasScreen extends CanvasScreenEvent {
  const CallNewFigureCanvasScreen(
    this.value,
  );

  final Enum value;

  @override
  List<Object?> get props => [value];
}

class SelectLineCanvasScreen extends CanvasScreenEvent {
  const SelectLineCanvasScreen(
    this.selectedLine,
  );

  final int selectedLine;

  @override
  List<Object?> get props => [selectedLine];
}

class SelectStartBendingCanvasScreen extends CanvasScreenEvent {
  const SelectStartBendingCanvasScreen(
    this.selectedBending,
  );

  final Bending selectedBending;

  @override
  List<Object?> get props => [selectedBending];
}

class SelectEndBendingCanvasScreen extends CanvasScreenEvent {
  const SelectEndBendingCanvasScreen(
    this.selectedBending,
  );

  final Bending selectedBending;

  @override
  List<Object?> get props => [selectedBending];
}
