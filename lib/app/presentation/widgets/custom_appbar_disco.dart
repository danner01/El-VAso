import 'package:el_vaso/app/config/theme/my_themes.dart';
import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../utilities/enums/theme_state_enum.dart';
import '../../config/injection/injection.dart';

import '../../config/routes/routes.dart';
import '../../domain/models/discoteca_model.dart';
import '../blocs/auth_cubit/auth_cubit.dart';

class CustomAppbarDisco extends StatelessWidget implements PreferredSizeWidget {
  final Discoteca selectDisco;

  const CustomAppbarDisco({super.key, required this.selectDisco});

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    // final authBloc = getIt.get<AuthCubit>();

    return PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: BlocBuilder<ConfigCubit, ConfigState>(
          builder: (contextState, configState) {
            return AppBar(
              backgroundColor: scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      context.go(Routes.home); // Acción al presionar el botón
                    },
                    icon: CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discoteca',
                        style: TextStyle(
                          fontSize: 14,
                          
                          color: configState.themeState == ThemeState.lightTheme
                              ? Colors.black
                              : Colors.white,
                          // fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${selectDisco.name}',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Boldfinger',
                          color: configState.themeState == ThemeState.lightTheme
                              ? Colors.black
                              : Colors.white,
                          // fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 22,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Image.asset(
                          'assets/icons/regalo.png',
                          fit: BoxFit.fitHeight,
                          width: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        maxRadius: 22,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Image.asset(
                          'assets/icons/ranking.png',
                          fit: BoxFit.fitHeight,
                          width: 25,
                        ),
                      ),
                    ],
                  ),
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
