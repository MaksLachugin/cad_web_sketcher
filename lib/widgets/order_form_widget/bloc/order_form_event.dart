part of 'order_form_bloc.dart';

sealed class OrderFormEvent extends Equatable {
  const OrderFormEvent();

  @override
  List<Object> get props => [];
}

class LoadOrderForm extends OrderFormEvent {
  const LoadOrderForm();

  @override
  List<Object> get props => [];
}
