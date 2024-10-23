import 'package:el_vaso/app/config/theme/my_themes.dart';
import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../utilities/enums/theme_state_enum.dart';
import '../../config/injection/injection.dart';
import '../../config/routes/routes.dart';
import '../blocs/auth_cubit/auth_cubit.dart';

class CustomAppbarHome extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final authBloc = getIt.get<AuthCubit>();

    return PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: BlocBuilder<ConfigCubit, ConfigState>(
          builder: (contextState, configState) {
            return AppBar(
              backgroundColor: scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              // leading: IconButton(
              //     onPressed: () {
              //       context.canPop();
              //     },
              //     icon: const Icon(Icons.arrow_back_ios)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    configState.themeState == ThemeState.lightTheme
                        ? 'assets/Logo Horizontal azul.png'
                        : 'assets/Logo Horizontal blanco.png',
                    fit: BoxFit.fitHeight,
                    width: 120,
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  IconButton(
                    icon: Icon(Icons.logout,
                        color: configState.themeState == ThemeState.lightTheme
                            ? Theme.of(context).primaryColor
                            : whiteColor),
                    onPressed: () {
                      authBloc.logout();
                      context.go(Routes.auth);
                    },
                  )
                ],
              ),

              //  flexibleSpace: Image.asset( 'assets/logo vaso white.png', ),
            );
          },
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
