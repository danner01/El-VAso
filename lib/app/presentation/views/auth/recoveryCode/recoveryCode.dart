import 'dart:developer';

import 'package:el_vaso/app/config/injection/injection.dart';
import 'package:el_vaso/app/presentation/blocs/auth_cubit/auth_cubit.dart';

import 'package:el_vaso/utilities/enums/login_state_enum.dart';
import 'package:el_vaso/utilities/handle_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../../config/theme/my_themes.dart';
import '../../../../domain/models/api_error.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../verificacion/verificationCodeInput.dart';

class RecoveryCodeView extends StatelessWidget {
  const RecoveryCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final verificacionCodeFormKey = GlobalKey<FormState>();
    late Color primary = Theme.of(context).primaryColor;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final codeTC = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: (Theme.of(context).scaffoldBackgroundColor.value ==
                  whiteColor.value)
              ? scaffoldBackgroundColor
              : scaffoldBackgroundColor,
          foregroundColor: (Theme.of(context).scaffoldBackgroundColor.value ==
                  whiteColor.value)
              ? primaryColor
              : Colors.white,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios))
          //  flexibleSpace: Image.asset( 'assets/logo vaso white.png', ),
          ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.verifyRecoveryState == VerifyRecoveryState.error) {
            log('Error:${state.verifyRecoveryState}');
            _showCustomDialog(context: context, state: state);
            codeTC.text = '';
          } else if (state.verifyRecoveryState == VerifyRecoveryState.success) {
            log('No Error:${state.verifyRecoveryState}');
            context.pushReplacement(Routes.recoveryNewPass);
          }
        },
        builder: (context, state) {
          return Form(
            autovalidateMode: AutovalidateMode.always,
            key: verificacionCodeFormKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              color: scaffoldBackgroundColor,
              child: Column(
                children: [
                  Image.asset(
                    (Theme.of(context).scaffoldBackgroundColor.value ==
                            whiteColor.value)
                        ? 'assets/Logo Vertical.png'
                        : 'assets/Logo Vertical white.png',
                    fit: BoxFit.fill,
                    width: (Theme.of(context).scaffoldBackgroundColor.value ==
                            whiteColor.value)
                        ? 180
                        : 260,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 50),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Introduce el código recibido',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: (Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .value ==
                                    whiteColor.value)
                                ? primaryColor
                                : Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Introduce el código de verificación que hemos enviado a tu correo electrónico',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),

                      const SizedBox(height: 20),
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

                      const SizedBox(height: 20),
                      CustomButton(
                        borderRadius: 25,
                        text: 'Confirmar',
                        loadingText: 'Confirmando',
                        isLoading: (state.loginState == LoginState.loading ||
                            state.registerSocialState ==
                                RegisterSocialState.loading),
                        onPressed: () {
                          // if (verificacionCodeFormKey.currentState!
                          //     .validate()) {
                          //   // authBloc.verifyEmail(codeTC.text);
                          // }
                          context.push(Routes.recoveryNewPass);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(' ¿No has recibido ningún código?',
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor, // Color del texto normal
                            )),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Vuelve a introducir tu correo electrónico',
                            style: TextStyle(
                              fontSize: 14,
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
