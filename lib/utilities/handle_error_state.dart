import 'package:el_vaso/app/domain/models/api_error.dart';
import 'package:el_vaso/app/presentation/widgets/custom_snackbars.dart';
import 'package:el_vaso/app/presentation/widgets/dialogs/custom_dialogs.dart';
import 'package:flutter/material.dart';

import 'enums/api_error_enum.dart';

void handleErrorState({
  required ApiError apiError,
  required BuildContext context,
}) {
  if (apiError.apiErrorType != ApiErrorType.none) {
    if (apiError.apiErrorType == ApiErrorType.unauthorized) {
      CustomSnackbars.noAuthenticatedError(context);
    } else if (apiError.apiErrorType == ApiErrorType.readMsg) {
      CustomDialogs.error(
        context,
        acceptOnPress: () {},
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Error',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              apiError.errorMsg ?? '',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      CustomDialogs.error(
        context,
        // text: apiError.apiErrorType.message,
        // title: 'Error',
        acceptOnPress: () {},
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Error',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              apiError.apiErrorType.message,
              textAlign: TextAlign.center,
            ),
            // SmallButton(
            //   smallButtonVariant: SmallButtonVariant.outlined,
            //   textColorBlack: true,
            //   text: 'Ver más detalles',
            //   onPressed: () {
            //     context.pop();
            //     CustomDialogs.error(
            //       context,
            //       title: 'Error',
            //       text: apiError.errorMsg,
            //       acceptOnPress: () {},
            //     );
            //   },
            // ),
          ],
        ),
      );
    }
  }
}
