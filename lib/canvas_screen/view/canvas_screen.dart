import 'package:cad_web_sketcher/canvas_screen/bloc/canvas_screen_bloc.dart';
import 'package:cad_web_sketcher/canvas_screen/widgets/widgets.dart';
import 'package:cad_web_sketcher/repo/models/base_element_enum.dart';
import 'package:cad_web_sketcher/repo/models/canvas_model.dart';
import 'package:cad_web_sketcher/repo/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  final _canvasScreenBloc = CanvasScreenBloc();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var values = [
      (RoofElements.abutment.className, RoofElements.values),
      (Parapets.flat.className, Parapets.values)
    ];

    String vers = _packageInfo.version;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          BlocBuilder<CanvasScreenBloc, CanvasScreenState>(
            bloc: _canvasScreenBloc,
            builder: (context, state) {
              if (state is CanvasScreenDrawed || state is CanvasScreenInitial) {
                return Column(
                  children: [
                    canvasField(state.canvasModel),
                    // SizedBox(height: 500, child: linesList(figure)),
                    // TextButton(
                    //   onPressed: () {
                    //     _canvasScreenBloc.add(ReDrawCanvasScreen(canvasModel));
                    //   },
                    //   child: Container(
                    //     padding:
                    //         const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    //     child: const Text('Flat Button'),
                    //   ),
                    // ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Поворот элемента на эскизе: ",
                                style: textTheme.bodyLarge,
                              ),
                              IconButton(
                                onPressed: () {
                                  state.canvasModel.angle -= 5;
                                },
                                icon: const Icon(Icons.rotate_left),
                              ),
                              IconButton(
                                onPressed: () {
                                  state.canvasModel.angle += 5;
                                },
                                icon: const Icon(Icons.rotate_right),
                              ),
                            ],
                          ),
                          expansionsTileFromEnums(
                              textTheme, "Готовые элементы", values),
                        ]),
                  ],
                );
              }
              if (state is CanvasScreenLoadingFailure) {
                return const Placeholder();
              }

              return const SizedBox(
                height: 500,
                child: Card(
                  color: Colors.black,
                ),
              );
            },
          ),
          Text(
            "v$vers",
            style: textTheme.bodyLarge,
          ),
        ],
      )),
    );
  }

  void callReDrawWithNewFigure(Enum value) {
    _canvasScreenBloc.add(ReDrawCanvasScreen(CanvasModel.fromEnum(value)));
  }

  Widget expansionsTileFromEnums(
      TextTheme textTheme, String name, List<(String, List<Enum>)> values) {
    return SizedBox(
        width: 270,
        child: ExpansionTile(
          title: const Text("Готовые элементы"),
          children: List.generate(values.length, (index) {
            var val = values[index];
            return ExpansionTileByEnumList(
              name: val.$1,
              onPress: callReDrawWithNewFigure,
              values: val.$2.map((e) => (e, getNameOfEnum(e))).toList(),
            );
          }),
        ));
  }

  ListView linesList(Figure figure) {
    return ListView.builder(
        itemBuilder: (context, i) {
          return LineTile(
            figure: figure,
            index: i,
          );
        },
        // separatorBuilder: (context, index) => const Divider(),
        itemCount: figure.length);
  }

  Widget canvasField(CanvasModel canvasModel) {
    return Center(
      child: SizedBox(
        height: 900,
        width: 900,
        child: Card(
          color: const Color.fromARGB(255, 193, 201, 194),
          child: CanvasWidget(canvasModel: canvasModel),
        ),
      ),
    );
  }
}
