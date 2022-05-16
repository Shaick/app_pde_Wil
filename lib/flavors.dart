enum Flavor {
  DEV,
  PROD,
}

extension FlavorName on Flavor {
  String get name => this.toString().split('.').last;
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'App dev';
      case Flavor.PROD:
        return 'Professor de Engenharia';
      default:
        return 'title';
    }
  }
}
