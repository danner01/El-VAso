import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../buttons/custom_button.dart';

class CustomDialogs {
  static noInternet(BuildContext context,
      {VoidCallback? cancelOnPress, bool dismissible = true}) {
    return AwesomeDialog(
      dismissOnTouchOutside: dismissible,
      dismissOnBackKeyPress: dismissible,
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      btnCancelText: 'Aceptar',
      btnCancelColor: const Color(0xFF00CA71),
      title: 'No hay internet',
      desc:
          'No hay conexión a internet. Por favor conéctese a una red WIFI o a los datos móviles.',
      btnCancelOnPress: () {
        if (cancelOnPress != null) {
          cancelOnPress();
        }
      },
    ).show();
  }

  static error(
    BuildContext context, {
    String? title,
    String? text,
    VoidCallback? acceptOnPress,
    bool dismissible = true,
    Widget? body,
  }) {
    return AwesomeDialog(
      dismissOnTouchOutside: dismissible,
      dismissOnBackKeyPress: dismissible,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      headerAnimationLoop: true,
      showCloseIcon: true,
      body: body,
      title: title ?? 'Error',
      desc: text,
      btnCancelColor: const Color(0xFF00CA71),
      btnCancelText: 'Aceptar',
      btnCancelOnPress: () {
        if (acceptOnPress != null) {
          acceptOnPress();
        }
      },
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }

  static ok(
    BuildContext context, {
    String? title,
    required String text,
    VoidCallback? onAccept,
    bool autoDismiss = true,
  }) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      autoDismiss: autoDismiss,
      showCloseIcon: true,
      title: title,
      closeIcon: !autoDismiss ? Container() : null,
      desc: text,
      btnOkOnPress: () {
        if (onAccept != null) {
          onAccept();
        }
      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {},
    ).show();
  }

  static loading(BuildContext context, {bool isText = false}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        elevation: 10,
        titlePadding: const EdgeInsets.symmetric(vertical: 40),
        // scrollable: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Column(
          children: [
            isText
                ? Text(
                    'Por favor espere...',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                : Container(),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  static question(BuildContext context,
      {String? title, required String text, void Function()? onPressOk}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      // title: 'Borrar',
      desc: text,
      buttonsTextStyle: const TextStyle(color: Colors.white),
      btnCancelText: 'Cancelar',
      showCloseIcon: true,
      btnCancelOnPress: () {},

      btnOkOnPress: onPressOk,
      dismissOnTouchOutside: true,
    ).show();
  }

  static inWork(BuildContext context) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        actionsPadding: const EdgeInsets.only(bottom: 10),
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: const Center(
            child: Text(
          '💻',
          style: TextStyle(fontSize: 50),
        )),
        content: const Text(
          'Aún estamos trabajando en esta funcionaliadad. 😏',
          textAlign: TextAlign.center,
        ),
        actions: [
          CustomButton(
              paddingH: 20, text: 'Aceptar', onPressed: () => context.pop())
        ],
      ),
    );
  }
}

class CustomLoading extends StatelessWidget {
  final Color? color;
  final double size;

  const CustomLoading({super.key, this.size = 250, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
          //color: this.color,
          strokeWidth: 6,
          // color: Colors.black,
        ),
      ),
    );
  }
}
