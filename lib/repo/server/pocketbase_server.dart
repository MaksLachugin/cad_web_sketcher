import 'package:cad_web_sketcher/repo/server/abstract_server.dart';
import 'package:cad_web_sketcher/repo/server/server_models/metal_color.dart';
import 'package:cad_web_sketcher/repo/server/server_models/metal_thickness.dart';
import 'package:cad_web_sketcher/repo/server/server_models/order.dart';
import 'package:cad_web_sketcher/repo/sketcher_models/figure.dart';
import 'package:get_it/get_it.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PocketbaseServer implements ADBServer {
  PocketBase pb = GetIt.I<PocketBase>();
  @override
  Future<List<MetalColor>> getColors() async {
    var records =
        await pb.collection("Color").getFullList(filter: 'is_available = true');
    return List.generate(
        records.length, (index) => MetalColor.fromMap(records[index].toJson()));
  }

  @override
  Future<Figure> getFigureByID(String id) async {
    var record = await pb.collection("order_view").getOne(id);

    return Figure.fromMap(record.data['figure_json']);
  }

  @override
  Future<List<MetalThickness>> getThickness() async {
    var records = await pb
        .collection("Thickness")
        .getFullList(filter: 'is_available = true');
    return List.generate(records.length,
        (index) => MetalThickness.fromMap(records[index].toJson()));
  }

  @override
  Future<void> sendOrder(Order order) async {
    final record = await pb.collection('Order').create(body: order.toMap());
    GetIt.I<Talker>().debug(record.toString());
  }

  @override
  Future<String> getStandartStatus() async {
    var record = await pb.collection('Status_base').getList(
          page: 1,
          perPage: 1,
        );
    return record.items.first.id;
  }
}
