import 'package:cad_web_sketcher/repo/server/abstract_server.dart';
import 'package:cad_web_sketcher/repo/server/server_models/metal_color.dart';
import 'package:cad_web_sketcher/repo/server/server_models/metal_thickness.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'order_form_event.dart';
part 'order_form_state.dart';

class OrderFormBloc extends Bloc<OrderFormEvent, OrderFormState> {
  OrderFormBloc(this.repo) : super(const OrderFormState()) {
    on<LoadOrderForm>(_load);
  }
  final ADBServer repo;

  Future<void> _load(
    LoadOrderForm event,
    Emitter<OrderFormState> emit,
  ) async {
    try {
      if (state is! OrderFormLoaded) {
        emit(const OrderFormLoading());
      }

      final colors = await repo.getColors();
      final thicknesses = await repo.getThickness();
      final orderStatus = await repo.getStandartStatus();

      emit(OrderFormLoaded(colors, thicknesses, orderStatus));
    } catch (e, st) {
      emit(OrderFormLoadingFailure(e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
