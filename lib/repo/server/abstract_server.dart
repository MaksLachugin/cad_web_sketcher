import 'package:cad_web_sketcher/repo/server/server_models/order.dart';
import 'package:cad_web_sketcher/repo/sketcher_models/figure.dart';

import 'server_models/metal_color.dart';
import 'server_models/metal_thickness.dart';

abstract class ADBServer {
  Future<List<MetalColor>> getColors();
  Future<List<MetalThickness>> getThickness();
  Future<String> getStandartStatus();
  void sendOrder(Order order);
  Future<Figure> getFigureByID(String id);
}
