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
        return "";
      case RoofElements.curvedRidge:
        return "";
      case RoofElements.endStripsForMetalRoofTiles:
        return "";
      case RoofElements.valleyTop:
        return "";
      case RoofElements.frontalLStrip:
        return "";
      case RoofElements.endCapForSoftFoofs:
        return "";
    }
  }
}
