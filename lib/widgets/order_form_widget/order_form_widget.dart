// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cad_web_sketcher/repo/server/pocketbase_server.dart';
import 'package:cad_web_sketcher/widgets/order_form_widget/bloc/order_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderFormWidget extends StatefulWidget {
  final void Function(
      String customer,
      String number,
      String email,
      String comment,
      String width,
      String count,
      String color,
      String thickness,
      String selectedStatus) sendDataOrder;
  const OrderFormWidget({
    super.key,
    required this.sendDataOrder,
  });

  @override
  OrderFormWidgetState createState() {
    return OrderFormWidgetState();
  }
}

class OrderFormWidgetState extends State<OrderFormWidget> {
  @override
  void initState() {
    _orderFormBloc.add(const LoadOrderForm());
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _orderFormBloc = OrderFormBloc(PocketbaseServer());
  String customer = '';
  String number = '';
  String email = '';
  String comment = '';
  String width = '';
  String count = '';
  String? selectedColor;
  String? selectedThickness;
  String? selectesStatus;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderFormBloc, OrderFormState>(
      bloc: _orderFormBloc,
      builder: (context, state) {
        if (state is OrderFormLoaded) {
          selectesStatus = state.orderStatus;
          selectedColor ??= state.metalColors.first.id;
          selectedThickness ??= state.metalThicknesses.first.id;

          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "ФИО",
                  ),
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return 'Укажите ФИО';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    customer = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Номер телефона",
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[0-9]"),
                    )
                  ],
                  validator: (value) {
                    if (value == null || value.length != 11) {
                      return 'Укажите номер телефона';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    number = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "email",
                  ),
                  validator: (value) {
                    if (value == null ||
                        !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                      return 'Укажите email';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    email = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Комментарий",
                  ),
                  onSaved: (newValue) {
                    comment = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Ширина детали",
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[0-9]"),
                    )
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'Укажите ширину детали в мм';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    width = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Количество деталей",
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[0-9]"),
                    )
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'Укажите количество деталей';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    count = newValue!;
                  },
                ),
                DropdownButtonFormField(
                  validator: (value) => value == null ? "Цвет не указан" : null,
                  value: selectedColor,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedColor = newValue!;
                    });
                  },
                  items: state.metalColors
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text('${e.name}\n ${e.ral}'),
                          ))
                      .toList(),
                ),
                DropdownButtonFormField(
                  validator: (value) =>
                      value == null ? "Толщина не указана" : null,
                  value: selectedThickness,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedThickness = newValue!;
                    });
                  },
                  items: state.metalThicknesses
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text('${e.name}\n'),
                          ))
                      .toList(),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState!.save();
                      widget.sendDataOrder(
                          customer,
                          number,
                          email,
                          comment,
                          width,
                          count,
                          selectedColor!,
                          selectedThickness!,
                          selectesStatus!);
                    }
                  },
                  child: const Text('Валидировать'),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
