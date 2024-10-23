import 'package:el_vaso/app/domain/models/eventos_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../utilities/date_functions.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.events,
  });

  final Eventos events;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Establecer la altura de cada tarjeta
      child: Stack(
        children: [
          // Imagen de fondo ajustada
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              events.imageUrl!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            //     FadeInImage.assetNetwork(
            //   placeholder:
            //       'assets/img/image_placeholder.png', // Imagen de placeholder (local o asset)
            //   image: events.imageUrl!, // URL de la imagen
            //   width: double.infinity,
            //   height: double.infinity,
            //   fit: BoxFit.cover,
            //   imageErrorBuilder: (context, error, stackTrace) {
            //     // Muestra una imagen o widget de error si la imagen falla al cargar
            //     return Image.asset(
            //       'assets/img/no_image.png', // Imagen de error
            //       width: double.infinity,
            //       height: double.infinity,
            //       fit: BoxFit.cover,
            //     );
            //   },
            // )
          ),
          Positioned(
            top: 15,
            left: 15,
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Discoteca:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      events.disco!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Boldfinger',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Título en la parte inferior
          Positioned(
            bottom: 30,
            left: 15,
            child: Text(
              events.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Boldfinger',
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatDateTime24h(events.dateEvent!)['formattedDate']
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // const SizedBox(width: 5),
                    const VerticalDivider(
                      color: Colors.white,
                      width: 5,
                    ),
                    // const SizedBox(width: 5),
                    Text(
                      formatDateTime24h(events.dateInit!)['formattedTime']
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Text(
                      '-',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      formatDateTime24h(events.dateEnd!)['formattedTime']
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize:9,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 