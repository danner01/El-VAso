import 'package:el_vaso/app/config/theme/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool lightTheme;
  final bool isLogin;

  const CustomAppbar(
      {super.key, this.title, required this.lightTheme, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: isLogin
              ? primaryColor
              : lightTheme
                  ? scaffoldBackgroundColor
                  : scaffoldBackgroundColor,
          foregroundColor: isLogin
              ? Colors.white
              : lightTheme
                  ? primaryColor
                  : Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                !lightTheme
                    ? 'assets/logo vaso white.png'
                    : isLogin
                        ? 'assets/logo vaso white.png'
                        : 'assets/logo vaso.png',
                fit: BoxFit.fill,
                width: isLogin
                    ? 80
                    : isLogin
                        ? 60
                        : 80,
              ),
              const SizedBox(
                width: 50,
              )
            ],
          ),
          leading: !isLogin
              ? IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios))
              : null,

          //  flexibleSpace: Image.asset( 'assets/logo vaso white.png', ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
