import 'package:el_vaso/app/config/injection/injection.dart';
import 'package:el_vaso/app/config/routes/routes.dart';
import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:el_vaso/app/presentation/widgets/buttons/custom_button.dart';
import 'package:el_vaso/utilities/enums/theme_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    late Color textColor = Theme.of(context).primaryColor;
    final configCubit = getIt.get<ConfigCubit>();

    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, configState) {
        return Scaffold(
            // drawer: const CustomDrawer(),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: IconButton(
              icon: configState.themeState != ThemeState.lightTheme
                  ? const Icon(
                      Icons.dark_mode,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.light_mode,
                      color: Colors.white,
                    ),
              onPressed: () {
                configCubit.onChangeTheme();
              },
            ),
           
            body: Stack(children: [
              // Imagen de fondo
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/Background.png'), // Ruta de la imagen en la carpeta assets
                    fit: BoxFit
                        .cover, // Ajusta la imagen para cubrir toda la pantalla
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: Image.asset(
                            'assets/ElVaso Logo 2.png',
                            scale: 0.75,
                          )),
                          CustomButton(
                              borderRadius: 25,
                              text: 'Inicia sesión',
                              onPressed: () => context.push(Routes.login)),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                              color: Colors.white,
                              textStyle: TextStyle(color: textColor),
                              borderRadius: 25,
                              text: 'Crea tu cuenta',
                              loadingText: 'Creando...',
                              onPressed: () => context.push(Routes.register)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('¿Quieres añadir un local a la app?',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14)),
                              const SizedBox(width: 2),
                              TextButton(
                                onPressed: () {
                                  // context.push(Routes.register);
                                },
                                child: const Text(
                                  'Contáctanos',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(Routes.home);
                        },
                        child: const Text(
                          'Accede como invitado',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationThickness: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
      },
    );
  }
}
