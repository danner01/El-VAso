import 'dart:developer';

import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../utilities/enums/theme_state_enum.dart';
import '../../../config/injection/injection.dart';
import '../../../config/routes/routes.dart';
import '../../blocs/internet_connectivity/internet_connectivity_bloc.dart';

import '../../blocs/user/user_bloc.dart';
import '../custom_snackbars.dart';

class BottomBarView extends StatefulWidget {
  final Widget child;
  final GoRouterState state;

  const BottomBarView({
    required this.child,
    super.key,
    required this.state,
  });

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  final iconSize = 30.0;

  int _currentIndex = 0;

  @override
  void initState() {
    getIt.get<UserBloc>().add(UserLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _changeItem();
    log('routes state: ${widget.state.fullpath}');

    return WillPopScope(
      onWillPop: () async => _onWillPop(context),
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar:
            BlocConsumer<InternetConnectivityBloc, InternetConnectivityState>(
          listener: (context, state) {
            if (state == InternetConnectivityState.noConnected) {
              CustomSnackbars.notInternet(context);
            } else if (state == InternetConnectivityState.connected) {
              CustomSnackbars.correct(
                  context: context, text: 'Vuelves a tener conexión');
            }
          },
          builder: (context, state) {
            return BottomNavigationBar(
              iconSize: 25,
              elevation: 20,
              unselectedFontSize: 10,
              selectedFontSize: 10,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w700),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).primaryColor,
              items: _buildBottomNavItems(context),
              currentIndex: _currentIndex, //_calculateSelectedIndex(context),
              onTap: (int idx) => _onItemTapped(index: idx, context: context),
            );
          },
        ),
      ),
    );
  }

// Método para construir los ítems del BottomNavigationBar
  List<BottomNavigationBarItem> _buildBottomNavItems(BuildContext context) {
    return _tabs.map((tab) {
      int index = _tabs.indexOf(tab);
      bool isSelected = _currentIndex == index;

      return BottomNavigationBarItem(
        icon: BlocBuilder<ConfigCubit, ConfigState>(
          builder: (context, configState) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent, // Cambia color del círculo
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  configState.themeState == ThemeState.lightTheme
                      ? isSelected
                          ? Colors.white
                          : Colors.black
                      : Colors.white,
                  BlendMode.srcIn,
                ),
                child: tab.icon,
              ),
            );
          },
        ),
        label: tab.label,
      );
    }).toList();
  }

  final List<MyCustomBottomNavBarItem> _tabs = [
    MyCustomBottomNavBarItem(
      icon: Image.asset(
        'assets/icons/li_home.png', // Imagen en vez de ícono
        height: 30.0,
        width: 30.0,
      ),
      label: '',
      initialLocation: Routes.home,
    ),
    MyCustomBottomNavBarItem(
      icon: Image.asset(
        'assets/icons/li_sms.png', // Imagen en vez de ícono
        height: 30.0,
        width: 30.0, // Cambiar el color de la imagen si es necesario
      ),
      label: '',
      initialLocation: Routes.chat,
    ),
    MyCustomBottomNavBarItem(
      icon: Image.asset(
        'assets/icons/li_ticket.png', // Imagen en vez de ícono
        height: 30.0,
        width: 30.0, // Cambiar el color de la imagen si es necesario
      ),
      label: '',
      initialLocation: Routes.entradas,
    ),
    MyCustomBottomNavBarItem(
      icon: Image.asset(
        'assets/icons/li_user.png', // Imagen en vez de ícono
        height: 30.0,
        width: 30.0, // Cambiar el color de la imagen si es necesario
      ),
      label: '',
      initialLocation: Routes.perfil,
    ),
  ];

  void _onItemTapped({
    required int index,
    required BuildContext context,
  }) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = _tabs[index].initialLocation;
    if (index == 3) {
      router.push(location);
    }

    setState(() {
      _currentIndex = index;
      router.go(location);
    });
  }

  void _changeItem() {
    final route = widget.state.fullpath;

    if (route!.contains(Routes.entradas)) {
      _currentIndex = 2;
      setState(() {});
      return;
    }

    switch (route) {
      case Routes.home:
        _currentIndex = 0;
        break;
      case Routes.discoteca:
        _currentIndex = 0;
        break;
      case Routes.evento:
        _currentIndex = 0;
        break;
      case Routes.chat:
        _currentIndex = 1;
        break;
      case Routes.entradas:
        _currentIndex = 2;
        break;
      case Routes.perfil:
        _currentIndex = 3;
        break;

      default:
        _currentIndex = 1;
    }
    setState(() {});
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 50,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text('¿Estás seguro qué deseas salir de la app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Sí'),
              ),
            ],
          ),
        )) ??
        false;
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem(
      {required this.initialLocation,
      required super.icon,
      super.label,
      Widget? activeIcon})
      : super(activeIcon: activeIcon ?? icon);
}
