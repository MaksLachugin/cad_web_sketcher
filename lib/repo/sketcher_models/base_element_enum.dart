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
