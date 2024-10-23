import 'dart:developer';

import 'package:el_vaso/app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:el_vaso/app/presentation/widgets/SplitScreen.dart';
import 'package:el_vaso/app/presentation/widgets/custom_appbar.dart';
import 'package:el_vaso/utilities/enums/login_state_enum.dart';
import 'package:el_vaso/utilities/enums/theme_state_enum.dart';
import 'package:el_vaso/utilities/handle_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/injection/injection.dart';
import '../../../../config/routes/routes.dart';
import '../../../../domain/models/api_error.dart';

import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/textfields/textfiled_custom.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();

    final authBloc = getIt.get<AuthCubit>();

    final emailTC = TextEditingController();
    final passwordTC = TextEditingController();

    late Color textColor = Theme.of(context).primaryColor;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      appBar: const CustomAppbar(
        isLogin: true,
        lightTheme: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.loginState == LoginState.error) {
            _showCustomDialog(context: context, state: state);
          } else if (state.loginState == LoginState.success ||
              state.registerSocialState == RegisterSocialState.success) {
            context.go(Routes.home);
          }
        },
        builder: (context, state) {
          return Form(
              autovalidateMode: AutovalidateMode.always,
              key: loginFormKey,
              child: SplitScreenWithOverlay(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: scaffoldBackgroundColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<ConfigCubit, ConfigState>(
                      builder: (context, configState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonRedes(
                                    icon: 'assets/google.png',
                                    onPressed: () =>
                                        authBloc.signInWithGoogle(),
                                  ),
                                  ButtonRedes(
                                    icon: 'assets/facebook.png',
                                    size: 25,
                                    paddintop: 7,
                                    onPressed: () =>
                                        authBloc.signInWithFacebook(),
                                  ),
                                  ButtonRedes(
                                    icon: 'assets/apple.png',
                                    colorIcon: configState.themeState ==
                                            ThemeState.lightTheme
                                        ? Colors.black
                                        : Colors.white,
                                    onPressed: () => authBloc.signInWithApple(),
                                  ),
                                ]),
                            // const SizedBox(height: 20),
                            const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Divider(),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'o',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Divider(),
                                  ),
                                ]),
                            // const SizedBox(height: 20),
                            TextFieldCustom(
                              controller: emailTC,
                              labelText: 'Correo',
                              textInputType: TextInputType.emailAddress,
                              hintText: 'Correo',
                              // icon: Icons.check,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El correo es obligatorio';
                                }
                                return null;
                              },
                            ),
                            // const SizedBox(height: 15),
                            TextFieldCustom(
                              controller: passwordTC,
                              labelText: 'Contraseña',
                              textInputType: TextInputType.text,
                              password: true,
                              hintText: 'Contraseña',
                              icon: Icons.abc_outlined,
                            ),
                            const SizedBox(height: 5),
                            TextButton(
                              onPressed: () {
                                context.push(Routes.recoveryPass);
                              },
                              child: Text(
                                '¿Has olvidado la contraseña?',
                                style: TextStyle(
                                  color: configState.themeState ==
                                          ThemeState.lightTheme
                                      ? textColor
                                      : Colors.white,

                                  fontWeight: FontWeight.w500,
                                  // shadows: [
                                  //   Shadow(
                                  //     offset: const Offset(
                                  //         2.0, 2.0), // Desplazamiento de la sombra
                                  //     blurRadius: 3.0, // Radio de desenfoque
                                  //     color: Colors.grey
                                  //         .withOpacity(0.5), // Color de la sombra
                                  //   ),
                                  // ],
                                ),
                              ),
                            ),
                            // const SizedBox(height: 15),
                            CustomButton(
                              borderRadius: 25,
                              text: 'Inicia sesión',
                              loadingText: 'Iniciando',
                              isLoading:
                                  (state.loginState == LoginState.loading ||
                                      state.registerSocialState ==
                                          RegisterSocialState.loading),
                              onPressed: () {
                                if (loginFormKey.currentState!.validate()) {
                                  authBloc.login(emailTC.text, passwordTC.text);
                                }
                              },
                            ),
                            // const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('¿No tienes cuenta?',
                                    style: TextStyle(
                                        //   shadows: [
                                        //   Shadow(
                                        //     offset: const Offset(2.0,
                                        //         2.0), // Desplazamiento de la sombra
                                        //     blurRadius: 3.0, // Radio de desenfoque
                                        //     color: Colors.grey
                                        //         .withOpacity(0.5), // Color de la sombra
                                        //   ),
                                        // ]
                                        )),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    context.push(Routes.register);
                                  },
                                  child: Text(
                                    'Regístrate',
                                    style: TextStyle(
                                      color: configState.themeState ==
                                              ThemeState.lightTheme
                                          ? textColor
                                          : Colors.white,
                                      fontWeight: FontWeight.w500,
                                      // shadows: [
                                      //   Shadow(
                                      //     offset: const Offset(2.0,
                                      //         2.0), // Desplazamiento de la sombra
                                      //     blurRadius: 3.0, // Radio de desenfoque
                                      //     color: Colors.grey.withOpacity(
                                      //         0.5), // Color de la sombra
                                      //   ),
                                      // ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    //   ],
                    // ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  _showCustomDialog({required BuildContext context, required AuthState state}) {
    if (state.loginState == LoginState.error ||
        state.registerSocialState == RegisterSocialState.error) {
      log(state.commonError.toString());
      handleErrorState(
        apiError: state.commonError as ApiError,
        context: context,
      );
    }
  }
}

class ButtonRedes extends StatelessWidget {
  final String? icon;
  final double? size;
  final Color? colorIcon;
  final double? paddintop;
  final VoidCallback? onPressed;

  const ButtonRedes(
      {super.key,
      this.icon,
      this.size = 15,
      this.paddintop = 0,
      this.onPressed,
      this.colorIcon});

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 2, left: 2),
        child: Container(
          // width: 100,
          height: 50,
          decoration: BoxDecoration(
            color: scaffoldBackgroundColor,
            border: Border.all(
              color: Colors.grey, // Color del borde
              width: 2, // Ancho del borde
            ),
            borderRadius: BorderRadius.circular(10), // Radio de los bordes
          ),
          child: IconButton(
            padding: EdgeInsets.only(top: paddintop!),
            icon: Image.asset(
              icon!,
              color: colorIcon,
              fit: BoxFit.fill,
              width: size,
            ),
            iconSize: 30,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
