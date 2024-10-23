import 'dart:developer';

import 'package:el_vaso/app/config/theme/my_themes.dart';
import 'package:el_vaso/app/domain/models/user_model.dart';
import 'package:el_vaso/app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:el_vaso/app/presentation/views/auth/login/login.dart';
import 'package:el_vaso/app/presentation/widgets/custom_appbar.dart';
import 'package:el_vaso/app/presentation/widgets/textfields/date_picker_custom.dart';
import 'package:el_vaso/app/presentation/widgets/textfields/textfiled_phone_custom.dart';
import 'package:el_vaso/utilities/date_functions.dart';
import 'package:el_vaso/utilities/enums/login_state_enum.dart';
import 'package:el_vaso/utilities/enums/theme_state_enum.dart';
import 'package:el_vaso/utilities/handle_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import '../../../config/injection/injection.dart';
import '../../../../config/injection/injection.dart';
import '../../../../config/routes/routes.dart';
import '../../../../domain/models/api_error.dart';

import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/textfields/textfiled_custom.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final registerFormKey = GlobalKey<FormState>();
    final authBloc = getIt.get<AuthCubit>();

    // final authBloc = getIt.get<AuthCubit>();

    final nameTC = TextEditingController();
    final lastNameTC = TextEditingController();
    final emailTC = TextEditingController();
    final passwordTC = TextEditingController();
    final dateTC = TextEditingController();
    final phoneTC = TextEditingController();
    late Color primary = Theme.of(context).primaryColor;
    final ValueNotifier<bool> isTermsAccepted = ValueNotifier<bool>(false);

    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, configState) {
        return Scaffold(
          appBar: CustomAppbar(
            isLogin: false,
            lightTheme: configState.themeState == ThemeState.lightTheme,
          ),
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.registerState == RegisterState.error) {
                _showCustomDialog(context: context, state: state);
              } else if (state.registerState == RegisterState.success) {
                context.pushReplacement(Routes.verificacion);
              } else if (state.registerSocialState ==
                  RegisterSocialState.success) {
                context.pushReplacement(Routes.home);
              }
            },
            builder: (context, state) {
              return Form(
                autovalidateMode: AutovalidateMode.always,
                key: registerFormKey,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  color: scaffoldBackgroundColor,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '¡Bienvenido!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: configState.themeState ==
                                      ThemeState.lightTheme
                                  ? primary
                                  : Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ButtonRedes(
                                  icon: 'assets/google.png',
                                  onPressed: () => authBloc.signInWithGoogle(),
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
                        ),
                        // const SizedBox(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey[500],
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'o',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ]),
                        // const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldCustom(
                                controller: nameTC,
                                labelText: 'Nombre',
                                textInputType: TextInputType.name,
                                hintText: 'Nombre',
                                // icon: Icons.check,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'El nombre es obligatorio';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextFieldCustom(
                                controller: lastNameTC,
                                labelText: 'Apellido',
                                textInputType: TextInputType.name,
                                hintText: 'Apellido',
                                // icon: Icons.check,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'El apellido es obligatorio';
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                        // const SizedBox(height: 10),
                        TextFieldCustom(
                          controller: emailTC,
                          labelText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          hintText: 'Email',
                          // icon: Icons.check,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'El correo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 10),
                        DatePickerCustom(
                          labelText: 'Fecha de nacimiento',
                          hintText: 'Fecha de nacimiento',
                          initialDate: DateTime.now(),
                          onDateSelected: (value) {
                            dateTC.text = dateTimeToString(value);
                          },
                        ),
                        // const SizedBox(height: 10),
                        TextFieldPhoneCustom(
                          controller: phoneTC,
                          labelText: 'Número de teléfono',
                          textInputType: TextInputType.phone,
                          hintText: 'Número de teléfono',
                          icon: Icons.phone_android,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'El número de teléfono es obligatorio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFieldCustom(
                          controller: passwordTC,
                          labelText: 'Contraseña',
                          textInputType: TextInputType.text,
                          password: true,
                          hintText: 'Contraseña',
                          icon: Icons.abc_outlined,
                        ),
                        // const SizedBox(height: 10),
                        Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: isTermsAccepted,
                              builder: (context, value, child) {
                                return Checkbox(
                                  value: value,
                                  side: const BorderSide(color: textColor),
                                  checkColor: configState.themeState ==
                                          ThemeState.lightTheme
                                      ? Colors.white
                                      : textColor,
                                  onChanged: (bool? newValue) {
                                    isTermsAccepted.value = newValue ?? false;
                                  },
                                );
                              },
                            ),
                            Expanded(
                              child: RichText(
                                  softWrap: true,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      const TextSpan(
                                          text: 'Acepto los ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                textColor, // Color del texto normal
                                          )),
                                      TextSpan(
                                        text: 'Términos de Uso ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: configState.themeState ==
                                                  ThemeState.lightTheme
                                              ? primary
                                              : Colors
                                                  .white, // Color del texto clicable
                                        ),
                                      ),
                                      const TextSpan(
                                          text: 'y la ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                textColor, // Color del texto normal
                                          )),
                                      TextSpan(
                                        text: 'Política de Privacida ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: configState.themeState ==
                                                  ThemeState.lightTheme
                                              ? primary
                                              : Colors.white, //
                                        ),
                                      ),
                                      const TextSpan(
                                          text: 'de ElVaso',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                textColor, // Color del texto normal
                                          )),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 10),
                        ValueListenableBuilder<bool>(
                            valueListenable: isTermsAccepted,
                            builder: (context, value, child) {
                              return CustomButton(
                                borderRadius: 25,
                                text: 'Crea tu cuenta',
                                loadingText: 'Creando...',
                                isLoading: (state.registerState ==
                                        RegisterState.loading ||
                                    state.registerSocialState ==
                                        RegisterSocialState.loading),
                                onPressed: isTermsAccepted.value
                                    ? () async {
                                        if (registerFormKey.currentState!
                                            .validate()) {
                                          final user = User(
                                              name: nameTC.text,
                                              lastname: lastNameTC.text,
                                              email: emailTC.text,
                                              password: passwordTC.text,
                                              birthdate:
                                                  stringToDateTime(dateTC.text),
                                              phoneNumber: phoneTC.text,
                                              roles: const ['admin']);
                                          context
                                              .read<AuthCubit>()
                                              .register(user);
                                        }
                                      }
                                    : null,
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  _showCustomDialog({required BuildContext context, required AuthState state}) {
    if (state.registerState == RegisterState.error||state.registerSocialState==RegisterSocialState.error) {
      log(state.commonError.toString());
      handleErrorState(
        apiError: state.commonError as ApiError,
        context: context,
      );
    }
  }
}
