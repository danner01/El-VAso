enum EnvironmentEnum { pro, dev }

class Environment {
  late EnvironmentEnum _environment;

  // Constructor privado
  Environment._privateConstructor();

  // Instancia única de la clase Environment
  static final Environment _instance = Environment._privateConstructor();

  // Método para acceder a la instancia única
  static Environment get i => _instance;

  EnvironmentEnum get value => _environment;

  set(EnvironmentEnum newValue) {
    _environment = newValue;
  }


  String get apiUrl =>'http://89.117.79.130:3000';
}
