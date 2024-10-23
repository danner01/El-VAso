import 'dart:developer';

import 'package:el_vaso/app/config/injection/injection.dart';

import 'package:el_vaso/app/domain/models/user_model.dart';
import 'package:el_vaso/app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:el_vaso/app/presentation/views/auth/verificacion/verificationCodeInput.dart';
import 'package:el_vaso/app/presentation/widgets/custom_appbar.dart';
import 'package:el_vaso/utilities/enums/login_state_enum.dart';
import 'package:el_vaso/utilities/handle_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../config/theme/my_themes.dart';
import '../../../../domain/models/api_error.dart';
import '../../../widgets/buttons/custom_button.dart';

class VerifyView extends StatelessWidget {
  const VerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final verificacionFormKey = GlobalKey<FormState>();
    late Color primary = Theme.of(context).primaryColor;

    final codeTC = TextEditingController();
    final authBloc = getIt.get<AuthCubit>();

    return Scaffold(
      appBar: CustomAppbar(
        isLogin: false,
        lightTheme: (Theme.of(context).scaffoldBackgroundColor.value ==
            whiteColor.value),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.verifyState == VerifyState.error) {
            log('Error:${state.verifyState}');
            _showCustomDialog(context: context, state: state);
            codeTC.text = "";
            // context.pushReplacement(Routes.register);
          } else if (state.verifyState == VerifyState.success) {
            log('No Error:${state.verifyState}');
            context.pushReplacement(Routes.login);
          }
        },
        builder: (context, state) {
          return Form(
            autovalidateMode: AutovalidateMode.always,
            key: verificacionFormKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(height: 50),
                  Text(
                    'Verifica tu correo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                            (Theme.of(context).scaffoldBackgroundColor.value ==
                                    whiteColor.value)
                                ? primary
                                : whiteColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 50),

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            (Theme.of(context).scaffoldBackgroundColor.value ==
                                    whiteColor.value)
                                ? Colors.white
                                : Colors.grey[850]),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          const Text(
                            'Introduce el código de verificación que hemos enviado a tu correo electrónico',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Divider(
                            color: textColor,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          VerificationCodeInput(
                            controller: codeTC,
                            onCompleted: (e) {
                              // if (verificacionFormKey.currentState!
                              //     .validate()) {
                              //   final code = codeTC.text;
                              //   log('CODE:$e');
                              //   authBloc.verify(
                              //       User.getUserLocal().email, code);
                              // }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            borderRadius: 25,
                            text: 'Aceptar',
                            loadingText: 'Reenviando código',
                            isLoading:
                                (state.resendState == ResendState.loading),
                            onPressed: () {
                              if (verificacionFormKey.currentState!
                                  .validate()) {
                                final code = codeTC.text;
                                log('CODE:${codeTC.text}');
                                authBloc.verify(
                                    User.getUserLocal().email, code);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            const Text(' ¿No has recibido ningún código?',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textColor, // Color del texto normal
                                )),
                            TextButton(
                              onPressed: () => {
                                authBloc.resendCode(User.getUserLocal().email)
                              },
                              child: Text(
                                'Volver a enviar ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: (Theme.of(context)
                                              .scaffoldBackgroundColor
                                              .value ==
                                          whiteColor.value)
                                      ? primary
                                      : whiteColor,
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _showCustomDialog({required BuildContext context, required AuthState state}) {
    if (state.verifyState == VerifyState.error) {
      log('SHOW ERROR:${state.commonError.toString()}');
      handleErrorState(
        apiError: state.commonError as ApiError,
        context: context,
      );
    }
  }
}
