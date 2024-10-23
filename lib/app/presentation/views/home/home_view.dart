import 'package:el_vaso/app/presentation/views/home/widgets/TabHomeCustom.dart';
import 'package:el_vaso/app/presentation/widgets/custom_appbar_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/disco/disco_bloc.dart';
import 'widgets/AutocompleteCustom/AutocompleteCustom.dart';
import 'widgets/CalendarFilter/calendarFilter.dart';
import 'widgets/DraggableWidget/draggableWidget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchTC = TextEditingController();

    return Scaffold(
      // drawer: const CustomDrawer(),
      appBar: const CustomAppbarHome(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            BlocBuilder<DiscoBloc, DiscoState>(
              builder: (context, stateDisco) {
                return Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                          height: 40,
                          child: AutocompleteCustom(
                            discotecas: stateDisco.discotecas,
                            search: searchTC.text,
                          )

                          //  TextFormField(
                          //   style: const TextStyle(
                          //     fontSize: 17,
                          //   ),
                          //   controller: searchTC,
                          //   decoration: InputDecoration(
                          //     contentPadding: const EdgeInsets.symmetric(
                          //         horizontal: 15.0,
                          //         vertical: 10.0), // Reduce el padding vertical

                          //     prefixIcon: Icon(
                          //       Icons.search_outlined,
                          //       color: Theme.of(context).colorScheme.primary,
                          //     ),
                          //     hoverColor:
                          //         Theme.of(context).canvasColor.withOpacity(0.2),
                          //     hintText: 'Buscar tu discoteca',
                          //     // Borde cuando el campo está habilitado y sin enfoque
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30.0),
                          //       borderSide: BorderSide(
                          //         color: Theme.of(context)
                          //             .colorScheme
                          //             .primary, // Cambia el color del borde cuando está habilitado
                          //         width: 2.0,
                          //       ),
                          //     ),

                          //     // Borde cuando el campo está enfocado
                          //     focusedBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30.0),
                          //       borderSide: const BorderSide(
                          //         color: Colors
                          //             .blue, // Cambia el color del borde cuando está enfocado
                          //         width: 2.0,
                          //       ),
                          //     ),

                          //     // Borde cuando el campo está deshabilitado
                          //     disabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30.0),
                          //       borderSide: BorderSide(
                          //         color: Theme.of(context)
                          //             .colorScheme
                          //             .primary, // Color del borde cuando está deshabilitado
                          //         width: 2.0,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor),
                        child: Image.asset(
                          'assets/icons/settings.png', // Imagen en vez de ícono
                          height: 15.0,
                          width:
                              15.0, // Cambiar el color de la imagen si es necesario
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return const DraggableScollCustom(
                              child: CustomCalendar(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            const Expanded(child: TabsHomeCustom())
          ],
        ),
      ),
    );
  }
}
