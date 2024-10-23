import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:el_vaso/app/presentation/views/home/widgets/Discotecas/discotecasList.dart';
import 'package:el_vaso/app/presentation/views/home/widgets/Eventos/eventosList.dart';
import 'package:el_vaso/utilities/enums/theme_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsHomeCustom extends StatefulWidget {
  const TabsHomeCustom({super.key});

  @override
  State<TabsHomeCustom> createState() => _TabsHomeCustomState();
}

class _TabsHomeCustomState extends State<TabsHomeCustom>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(
        _handleTabChange); // Eliminar listener antes de eliminar el controller
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    // Verificar cuando el cambio de tab se completa
    if (_tabController.index != _tabController.previousIndex) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    late Color primaryColor = Theme.of(context).primaryColor;

    const kTabPages = <Widget>[
      DiscotecasListView(),
      EventosListView(),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: BlocBuilder<ConfigCubit, ConfigState>(
            builder: (context, configState) {
              return TabBar(
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                tabs: [
                  Tab(
                    icon: Container(
                      padding: const EdgeInsets.only(
                          right: 10, left: 10, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(20),
                        color: _tabController.index == 0
                            ? primaryColor
                            : Colors.transparent,
                      ),
                      child: Text(
                        'Discotecas',
                        style: TextStyle(
                          color: configState.themeState == ThemeState.lightTheme
                              ? _tabController.index == 0
                                  ? Colors.white
                                  : primaryColor
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    icon: Container(
                      padding: const EdgeInsets.only(
                          right: 10, left: 10, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(20),
                        color: _tabController.index == 1
                            ? primaryColor
                            : Colors.transparent,
                      ),
                      child: Text(
                        'Eventos',
                        style: TextStyle(
                          color: configState.themeState == ThemeState.lightTheme
                              ? _tabController.index == 1
                                  ? Colors.white
                                  : primaryColor
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
                isScrollable: true,
                indicator:
                    const BoxDecoration(), // Sin línea debajo de los ítems
                dividerColor: Colors.transparent,
              );
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: kTabPages,
        ),
      ),
    );
  }
}
