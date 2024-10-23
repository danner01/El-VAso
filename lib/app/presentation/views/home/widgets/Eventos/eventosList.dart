import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../utilities/enums/theme_state_enum.dart';
import '../../../../../domain/models/eventos_model.dart';
import '../../../../blocs/config_cubit/config_cubit.dart';
import 'eventsCard.dart';

final List<Eventos> itemsEvents = [
  Eventos(
    imageUrl: 'assets/img/Evento 1.png',
    name: 'EVENTO 1',
    disco: 'DISCO 1',
    dateEvent: DateTime.now(),
    dateInit: DateTime.now(),
    dateEnd: DateTime.now(),
    // fecha: 'Viernes 16 de Agosto',
    // hora: '12:00 - 6:00'
  ),
  Eventos(
    imageUrl: 'assets/img/Evento 2.png',
    name: 'EVENTO 2',
    disco: 'DISCO 2',
    dateEvent: DateTime.now(),
    dateInit: DateTime.now(),
    dateEnd: DateTime.now(),
    // fecha: 'Viernes 16 de Agosto',
    // hora: '12:00 - 6:00'
  ),
  Eventos(
    imageUrl: 'assets/img/Evento 3.png',
    name: 'EVENTO 3',
    disco: 'DISCO 3',
    dateEvent: DateTime.now(),
    dateInit: DateTime.now(),
    dateEnd: DateTime.now(),
    // fecha: 'Viernes 16 de Agosto',
    // hora: '12:00 - 6:00'
  ),
  Eventos(
    imageUrl: 'assets/img/Evento 4.png',
    name: 'EVENTO 4',
    disco: 'DISCO 4',
    dateEvent: DateTime.now(),
    dateInit: DateTime.now(),
    dateEnd: DateTime.now(),
    // fecha: 'Viernes 16 de Agosto',
    // hora: '12:00 - 6:00'
  ),
];

class EventosListView extends StatelessWidget {
  const EventosListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, configState) {
        return Center(
            child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Eventos',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: configState.themeState == ThemeState.lightTheme
                          ? Theme.of(context).primaryColor
                          : Colors.white),
                ),
              ],
            ),
            Expanded(
                child: GridView.builder(
              itemCount: itemsEvents.length,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas
                crossAxisSpacing: 5, // Espacio horizontal entre columnas
                mainAxisSpacing: 5, // Espacio vertical entre filas
                childAspectRatio: 0.75, // Relación de aspecto para las tarjetas
              ),
              itemBuilder: (context, index) {
                return EventCard(events: itemsEvents[index]);
              },
            )),
          ],
        ));
      },
    );
  }
}
