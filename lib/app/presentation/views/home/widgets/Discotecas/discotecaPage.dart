import 'dart:developer';

import 'package:el_vaso/app/presentation/blocs/config_cubit/config_cubit.dart';
import 'package:el_vaso/app/presentation/widgets/custom_appbar_disco.dart';
import 'package:el_vaso/utilities/enums/disco_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../utilities/enums/theme_state_enum.dart';
import '../../../../../../utilities/handle_error_state.dart';
import '../../../../../config/injection/injection.dart';
import '../../../../blocs/disco/disco_bloc.dart';
import '../carrusel.dart';
import 'discoCard.dart';

class DiscotecaPageView extends StatefulWidget {
  const DiscotecaPageView({super.key});

  @override
  State<DiscotecaPageView> createState() => _DiscotecaPageViewState();
}

class _DiscotecaPageViewState extends State<DiscotecaPageView> {
  final _discoBloc = getIt.get<DiscoBloc>();

  @override
  void initState() {
    _discoBloc.add(ResetDiscoEvent());
    _discoBloc.add(const DiscoGetAllEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscoBloc, DiscoState>(
      listener: (context, stateDiscos) {
        if (stateDiscos.getDiscoByIdState == GetDiscoByIdState.error) {
          _showCustomDialog(context: context, state: stateDiscos);
        }
      },
      builder: (context, stateDiscos) {
        return Scaffold(
          // drawer: const CustomDrawer(),
          appBar: CustomAppbarDisco(selectDisco: stateDiscos.selectDisco),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: BlocBuilder<ConfigCubit, ConfigState>(
              builder: (context, configState) {
                return Center(
                    child: Column(
                  children: const [
                    Image.asset(
                      disco.banner!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ],
                ));
              },
            ),
          ),
        );
      },
    );
  }
}

_showCustomDialog({required BuildContext context, required DiscoState state}) {
  if (state.getDiscoByIdState == GetDiscoByIdState.error) {
    log(state.apiError.toString());
    handleErrorState(
      apiError: state.apiError,
      context: context,
    );
  }
}
