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
  String get className {
    switch (this) {
      default:
        return "Элементы кровли";
    }
  }

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

  String get imagePath {
    switch (this) {
      case RoofElements.abutment:
        return "png/roof_elements/abutment.png";
      case RoofElements.drip:
        return "png/roof_elements/drip.png";
      case RoofElements.simpleRidge:
        return "png/roof_elements/simpleRidge.png";
      case RoofElements.snowStop:
        return "png/roof_elements/snowStop.png";
      case RoofElements.valleyBottom:
        return "png/roof_elements/valleyBottom.png";
      case RoofElements.curvedRidge:
        return "png/roof_elements/curvedRidge.png";
      case RoofElements.endStripsForMetalRoofTiles:
        return "png/roof_elements/endStripsForMetalRoofTiles.png";
      case RoofElements.valleyTop:
        return "png/roof_elements/valleyTop.png";
      case RoofElements.frontalLStrip:
        return "png/roof_elements/frontalLStrip.png";
      case RoofElements.endCapForSoftFoofs:
        return "png/roof_elements/endCapForSoftFoofs.png";
    }
  }
}

enum Parapets {
  flat,
  shaped,
}

extension ParapetsExtension on Parapets {
  String get className {
    return "Парапеты";
  }

  String get name {
    switch (this) {
      case Parapets.flat:
        return "Плоский парапет";
      case Parapets.shaped:
        return "Фигурный парапет";
    }
  }

  String get imagePath {
    switch (this) {
      case Parapets.flat:
        return "png/parapets/flat.png";
      case Parapets.shaped:
        return "png/parapets/shaped.png";
    }
  }
}

String getNameOfEnum(Enum value) {
  switch (value.runtimeType) {
    case const (RoofElements):
      return (value as RoofElements).name;
    case const (Parapets):
      return (value as Parapets).name;
    default:
      return "Error";
  }
}

String getAssetImage(Enum value) {
  switch (value.runtimeType) {
    case const (RoofElements):
      return (value as RoofElements).imagePath;
    case const (Parapets):
      return (value as Parapets).imagePath;
    default:
      return "Error";
  }
}
