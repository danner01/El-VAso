import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:el_vaso/app/data/datasources_impl/auth_remote_datasource_impl.dart';
import 'package:el_vaso/app/data/datasources_impl/event_remote_datasource_impl.dart';
import 'package:el_vaso/app/data/repositories_impl/auth_repository_impl.dart';
import 'package:el_vaso/app/data/repositories_impl/event_repository_impl.dart';
import 'package:el_vaso/app/domain/datasources/auth_datasource.dart';
import 'package:el_vaso/app/domain/datasources/event_datasource.dart';
import 'package:el_vaso/app/domain/repositories/auth_repository.dart';
import 'package:el_vaso/app/domain/repositories/event_repository.dart';
import 'package:el_vaso/app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:el_vaso/app/presentation/blocs/disco/disco_bloc.dart';
import 'package:el_vaso/app/presentation/blocs/internet_connectivity/internet_connectivity_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources_impl/disco_remote_datasource_impl.dart';
import '../../data/datasources_impl/user_remote_datasource_impl.dart';
import '../../data/local/user_local_datasource_impl.dart';
import '../../data/repositories_impl/disco_repository_impl.dart';
import '../../data/repositories_impl/user_repository_impl.dart';
import '../../domain/datasources/disco_datasource.dart';
import '../../domain/datasources/user_datasource.dart';
import '../../domain/repositories/disco_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../presentation/blocs/user/user_bloc.dart';
import '../http/api.dart';
import '../local_storage/local_storage.dart';

final getIt = GetIt.I;

Future<void> setupInjection() async {
  final logger = Logger();
  logger.log(Level.info, 'Inicio de la configuracion de dependencias');

  // ------------------- Packages -----------------------

  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton(LocalStorage(prefs));

  getIt.registerSingleton(Client());

  getIt.registerSingleton(Connectivity());

  // ---------------------------------------------------------------------------

  getIt.registerSingleton(
    Api(
      client: getIt(),
      localStorage: getIt(),
    ),
  );

  // ---------------------------------------------------------------------------

  getIt.registerSingleton(InternetConnectivityBloc(
    connectivity: getIt(),
  ));

  // --------------------------------- DataSources -----------------------------

  getIt.registerFactory<AuthDataSource>(
    () => AuthRemoteDatasourceImpl(getIt.get()),
    instanceName: 'AuthRemoteDatasourceImpl',
  );

  getIt.registerFactory<UserDatasource>(
    () => UserRemoteDatasourceImpl(
      api: getIt(),
    ),
    instanceName: 'UserRemoteDatasourceImpl',
  );

  getIt.registerFactory<UserDatasource>(
    () => UserLocalDatasourceImpl(
      localStorage: getIt(),
    ),
    instanceName: 'UserLocalDatasourceImpl',
  );

  getIt.registerFactory<DiscoDatasource>(
    () => DiscoRemoteDatasourceImpl(
      api: getIt(),
    ),
    instanceName: 'DiscoRemoteDatasourceImpl',
  );

  getIt.registerFactory<EventDatasource>(
    () => EventRemoteDatasourceImpl(
      api: getIt(),
    ),
    instanceName: 'EventRemoteDatasourceImpl',
  );

  // --------------------------------- Repositories -----------------------------

  getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        authRemoteDataSource: getIt<AuthDataSource>(
          instanceName: 'AuthRemoteDatasourceImpl',
        ),
      ));

  getIt.registerFactory<DiscoRepository>(
    () => DiscoRepositoryImpl(
      discoRemoteDatasource:
          getIt<DiscoDatasource>(instanceName: 'DiscoRemoteDatasourceImpl'),
    ),
  );

    getIt.registerFactory<EventRepository>(
    () => EventRepositoryImpl(
     eventRemoteDatasource:
          getIt<EventDatasource>(instanceName: 'EventRemoteDatasourceImpl'),
    ),
  );

  getIt.registerFactory<UserRepository>(
    () => UserRepositoryImpl(
      localStorage: getIt(),
      userRemoteDatasource:
          getIt<UserDatasource>(instanceName: 'UserRemoteDatasourceImpl'),
      userLocalDatasource:
          getIt<UserDatasource>(instanceName: 'UserLocalDatasourceImpl'),
    ),
  );
  // --------------------------------- Services -----------------------------

  // --------------------------------- Blocs -----------------------------
  getIt.registerSingleton(AuthCubit(
    authRepository: getIt(),
    internetConnection: getIt(),
    localStorage: getIt(),
  ));

  getIt.registerSingleton(ConfigCubit(
    localStorage: getIt(),
  ));

  getIt.registerSingleton(UserBloc(
    userRepository: getIt(),
    internetConnection: getIt(),
  ));

  getIt.registerSingleton(DiscoBloc(
    discoRepository: getIt(),
    internetConnection: getIt(),
  ));

  logger.log(Level.info, 'Fin de la configuracion de dependencias');
}
