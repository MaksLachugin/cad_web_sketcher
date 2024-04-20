// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_form_bloc.dart';

class OrderFormState extends Equatable {
  const OrderFormState();

  @override
  List<Object> get props => [];
}

class OrderFormLoading extends OrderFormState {
  const OrderFormLoading();
}

class OrderFormLoaded extends OrderFormState {
  const OrderFormLoaded(
    this.metalColors,
    this.metalThicknesses,
    this.orderStatus,
  );

  final List<MetalColor> metalColors;
  final List<MetalThickness> metalThicknesses;
  final String orderStatus;

  @override
  List<Object> get props => [metalColors, metalThicknesses, orderStatus];
}

class OrderFormLoadingFailure extends OrderFormState {
  const OrderFormLoadingFailure(this.exception);

  final Object exception;

  @override
  List<Object> get props => super.props..add(exception);
}
