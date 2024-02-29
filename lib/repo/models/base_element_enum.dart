enum RoofElements {
  abutment,
  drip,
  simpleRidge,
  snowStop,
  valleyBottom,
  curvedRidge,
  endStripsForMetalRoofTiles,
  valleyTop,
  frontalLStrip,
  endCapForSoftFoofs,
}

extension RoofElementsExtension on RoofElements {
  String get name {
    switch (this) {
      case RoofElements.abutment:
        return "Примыкание";
      case RoofElements.drip:
        return "Капельник";
      case RoofElements.simpleRidge:
        return "Конек простой";
      case RoofElements.snowStop:
        return "Снеговой упор";
      case RoofElements.valleyBottom:
        return "Ендова нижняя";
      case RoofElements.curvedRidge:
        return "Конек фигурный";
      case RoofElements.endStripsForMetalRoofTiles:
        return "Торцевая для металлочерепицы";
      case RoofElements.valleyTop:
        return "Ендова верхняя";
      case RoofElements.frontalLStrip:
        return "Лобовая L-планка";
      case RoofElements.endCapForSoftFoofs:
        return "Торцевая для мягкой кровли";
    }
  }
}
