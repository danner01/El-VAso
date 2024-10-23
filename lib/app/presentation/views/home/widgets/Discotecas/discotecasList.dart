import 'dart:developer';

import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:el_vaso/utilities/enums/disco_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../utilities/enums/theme_state_enum.dart';
import '../../../../../../utilities/handle_error_state.dart';
import '../../../../../config/injection/injection.dart';
import '../../../../../config/routes/routes.dart';
import '../../../../blocs/disco/disco_bloc.dart';
import '../carrusel.dart';
import 'discoCard.dart';

class DiscotecasListView extends StatefulWidget {
  const DiscotecasListView({super.key});

  @override
  State<DiscotecasListView> createState() => _DiscotecasListViewState();
}

class _DiscotecasListViewState extends State<DiscotecasListView> {
  final _discoBloc = getIt.get<DiscoBloc>();

  @override
  void initState() {
    _discoBloc.add(const DiscoGetAllEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, configState) {
        return BlocConsumer<DiscoBloc, DiscoState>(
          listener: (context, state) {
            if (state.getDiscoState == GetDiscoState.error ||
                state.getFavDiscoState == GetFavDiscoState.error ||
                state.getDiscoByIdState == GetDiscoByIdState.error) {
              _showCustomDialog(context: context, state: state);
            } else if (state.getDiscoByIdState == GetDiscoByIdState.success) {
              context.go(Routes.discoteca);
            }
          },
          builder: (context, stateDiscos) {
            log('DISCOS:${stateDiscos.discosFiltradas.length}');
            return SingleChildScrollView(
              // Esto permite que la columna principal haga scroll
              child: Column(
                children: [
                  SizedBox(
                    height: 160,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Favoritos',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: configState.themeState ==
                                          ThemeState.lightTheme
                                      ? Theme.of(context).primaryColor
                                      : Colors.white),
                            ),
                          ],
                        ),
                        CarouselCard(
                          discos: stateDiscos.discosFavs,
                        ),
                        Row(
                          children: [
                            Text(
                              'Discotecas',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: configState.themeState ==
                                          ThemeState.lightTheme
                                      ? Theme.of(context).primaryColor
                                      : Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Expanded no es necesario aquí porque ListView.builder estará en shrinkWrap
                  ListView.builder(
                    itemCount: stateDiscos.discosFiltradas.length,
                    shrinkWrap:
                        true, // Permite que el ListView tome el tamaño que necesita
                    physics:
                        const NeverScrollableScrollPhysics(), // Desactiva el scroll interno
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: InkWell(
                          onTap: () => _discoBloc
                              .add(SelectedDiscoEvent(stateDiscos.discosFiltradas[index].id)),
                          child: DiscoCard(
                              disco: stateDiscos.discosFiltradas[index]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

_showCustomDialog({required BuildContext context, required DiscoState state}) {
  if (state.getDiscoState == GetDiscoState.error ||
      state.getFavDiscoState == GetFavDiscoState.error ||
      state.getDiscoByIdState == GetDiscoByIdState.error) {
    log(state.apiError.toString());
    handleErrorState(
      apiError: state.apiError,
      context: context,
    );
  }
}
