import 'dart:developer';

import 'package:el_vaso/app/config/routes/routes.dart';
import 'package:el_vaso/app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:el_vaso/app/presentation/views/home/home_view.dart';
import 'package:el_vaso/app/presentation/views/lobby/lobby.dart';
import 'package:el_vaso/app/presentation/views/auth/register/register.dart';
import 'package:el_vaso/app/presentation/views/splash/splash_view.dart';
import 'package:el_vaso/app/presentation/views/auth/verificacion/verificacion.dart';
import 'package:el_vaso/utilities/enums/login_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/views/auth/recoveryCode/recoveryCode.dart';
import '../../presentation/views/auth/recoveryNewPass/recoveryNewPass.dart';
import '../../presentation/views/auth/recoverypass/recoverypass.dart';
import '../../presentation/views/chat/chat_view.dart';
import '../../presentation/views/entradas/entradas_view.dart';
import '../../presentation/views/auth/login/login.dart';
import '../../presentation/views/home/widgets/Discotecas/discotecaPage.dart';
import '../../presentation/views/perfil/perfil_view.dart';
import '../../presentation/widgets/bottom_bar/bottom_bar_view.dart';
import '../injection/injection.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.splash, //Routes.splash,
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.splash,
      name: Routes.splash,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashView(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (BuildContext context, GoRouterState state) => const LoginView(),
    ),
    GoRoute(
      path: Routes.register,
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterView(),
    ),

    GoRoute(
      path: Routes.verificacion,
      builder: (BuildContext context, GoRouterState state) =>
          const VerifyView(),
    ),
    GoRoute(
      path: Routes.recoveryPass,
      builder: (BuildContext context, GoRouterState state) =>
          const RecoveryPassView(),
    ),
    GoRoute(
      path: Routes.recoveryNewPass,
      builder: (BuildContext context, GoRouterState state) =>
          const RecoveryNewPassView(),
    ),
    GoRoute(
      path: Routes.recoveryCode,
      builder: (BuildContext context, GoRouterState state) =>
          const RecoveryCodeView(),
    ),

    GoRoute(
      path: Routes.auth,
      builder: (BuildContext context, GoRouterState state) => const LobbyView(),
    ),

    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BottomBarView(state: state, child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            name: RouteName.home,
            path: Routes.home,
            builder: (BuildContext context, GoRouterState state) {
              return const HomeView();
            },
            // routes:<RouteBase>[

            // ]
          ),
          GoRoute(
            name: RouteName.discoteca,
            path: Routes.discoteca,
            builder: (BuildContext context, GoRouterState state) =>
                const DiscotecaPageView(),
          ),

          GoRoute(
            name: RouteName.chat,
            path: Routes.chat,
            builder: (BuildContext context, GoRouterState state) =>
                const ChatView(),
          ),
          GoRoute(
            name: RouteName.entradas,
            path: Routes.entradas,
            builder: (BuildContext context, GoRouterState state) =>
                const EntradasView(),
          ),
          GoRoute(
            path: Routes.perfil,
            builder: (BuildContext context, GoRouterState state) =>
                const PerfilView(),
          ),
        ]),

    //
  ],
  redirect: _authGuard,
  refreshListenable: getIt.get<AuthCubit>(),
);

String? _authGuard(BuildContext context, GoRouterState state) {
  log('🚀🚀🚀 ${state.location}');

  final loginState = BlocProvider.of<AuthCubit>(context, listen: false).state;

  if (state.location == Routes.register ||
      state.location == Routes.recoveryPass ||
      state.location == Routes.recoveryNewPass ||
      state.location == Routes.recoveryCode ||
      state.location == Routes.login ||
      state.location == Routes.verificacion ||
      state.location == Routes.auth ||
      state.location == Routes.splash ||
      state.location == Routes.home||
      state.location == Routes.discoteca
      ) {
    return null;
  } else {
    if (loginState.loginState == LoginState.noAuth) {
      return Routes.auth;
    }
  }

  return null;
}
