import 'package:cad_web_sketcher/repo/server/pocketbase_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  OrderFormState createState() {
    return OrderFormState();
  }
}

class OrderFormState extends State<OrderForm> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String customer = '';
  String number = '';
  String email = '';
  String comment = '';
  String width = '';
  String count = '';
  String? selectedValue = null;
  @override
  Widget build(BuildContext context) {
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
          TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState!.save();
              }
            },
            child: Text('Валидировать'),
          ),
          // DropdownButtonFormField(
          //   validator: (value) => value == null ? "Select a country" : null,
          //   value: selectedValue,
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedValue = newValue!;
          //     });
          //   },
          //   items: PocketbaseServer().getColors().then(
          //         (value) => List.generate(
          //           value.length,
          //           (index) => DropdownMenuItem(
          //             value: value[index].id,
          //             child: Text(
          //               '${value[index].name}\n ${value[index].ral}',
          //             ),
          //           ),
          //         ),
          //       ),
          // )
        ],
      ),
    );
  }
}
