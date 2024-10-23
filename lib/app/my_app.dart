import 'package:el_vaso/app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:el_vaso/app/presentation/blocs/internet_connectivity/internet_connectivity_bloc.dart';
import 'package:el_vaso/utilities/enums/theme_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// import 'config/environment.dart';
import 'config/injection/injection.dart';
import 'config/routes/router.dart';
import 'config/theme/my_themes.dart';
import 'presentation/blocs/disco/disco_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt.get<InternetConnectivityBloc>()),
        BlocProvider<AuthCubit>(
          create: (_) => getIt.get<AuthCubit>(),
          lazy: false,
        ),
        BlocProvider<ConfigCubit>(
          create: (_) => getIt.get<ConfigCubit>(),
          lazy: false,
        ),
        BlocProvider<DiscoBloc>(
          create: (_) => getIt.get<DiscoBloc>(),
          lazy: false,
        ),
      ],
      child: BlocBuilder<ConfigCubit, ConfigState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'El vaso',
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('es', ''),
            ],
            theme: state.themeState == ThemeState.lightTheme
                ? MyThemes.lightTheme
                : MyThemes.darkTheme,
            routerConfig: router,
          );
        },
      ),
    );
  }
}

// class AppWrapper extends StatefulWidget {
//   final Widget child;
//   const AppWrapper({Key? key, required this.child}) : super(key: key);

//   @override
//   State<AppWrapper> createState() => _AppWrapperState();
// }

// class _AppWrapperState extends State<AppWrapper> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<PremiumBloc, PremiumState>(
//         // listener: (context, state) {
//         //   if (state.openPaymentView) {
//         //     context.go(Routes.payment);
//         //   }
//         // },
//         builder: (context, state) {
//           if (state.openPaymentView) {
//             return const PremiumAccess2View();
//           }
//           return widget.child;
//         },
//       ),
//     );
//   }
// }
