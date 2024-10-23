import 'package:el_vaso/app/config/theme/my_themes.dart';
import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:el_vaso/utilities/enums/theme_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplitScreenWithOverlay extends StatelessWidget {
  final Widget child;

  const SplitScreenWithOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      body: BlocBuilder<ConfigCubit, ConfigState>(
        builder: (context, configState) {
          return Stack(
            children: [
              // Fondo dividido en dos colores
              Column(
                children: [
                  // Mitad superior
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: primaryColor, // Color de la mitad superior
                      child: const Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              'Accede a tu cuenta',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(height: 0),
                          Text(
                            'Selecciona un método de inicio de sesión:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Mitad inferior
                  Expanded(
                    child: Container(
                      color: configState.themeState == ThemeState.lightTheme
                          ? Colors.white30 // Color de la mitad inferior
                          : Colors.black, // Color de la mitad inferior
                    ),
                  ),
                ],
              ),
              // Container con elevación
              Positioned(
                top: MediaQuery.of(context).size.height * 0.18,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Material(
                    borderRadius: BorderRadius.circular(16),
                    elevation: 8,
                    child: Container(
                      width: 340,
                      height: 460,
                      decoration: BoxDecoration(
                        color: scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
