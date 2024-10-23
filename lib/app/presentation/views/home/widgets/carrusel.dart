import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection/injection.dart';
import '../../../../domain/models/discoteca_model.dart';
import '../../../blocs/disco/disco_bloc.dart';

class CarouselCard extends StatelessWidget {
  final List<Discoteca> discos;

  const CarouselCard({super.key, required this.discos});

  @override
  Widget build(BuildContext context) {
    // Obtener el ancho de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    // Calcular cuántas tarjetas entran en el ancho de la pantalla
    const cardWidth = 160.0;
    final viewportFraction = cardWidth / screenWidth;
    final discoBloc = getIt.get<DiscoBloc>();

    return SizedBox(
      height: 100, // Ajustar la altura del carrusel según sea necesario
      child: BlocBuilder<DiscoBloc, DiscoState>(
        builder: (context, state) {
          return ListView.builder(
            controller: PageController(viewportFraction: viewportFraction),
            itemCount: discos.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 100,
                width: cardWidth, // Ancho de la tarjeta
                child: InkWell(
                  onTap: () =>
                      discoBloc.add(SelectedDiscoEvent(discos[index].id)),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        // Imagen de fondo ajustada
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            discos[index].banner!, // Imagen en vez de ícono
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                        //      FadeInImage.assetNetwork(
                        //   placeholder:
                        //       'assets/img/image_placeholder.png', // Imagen de placeholder (local o asset)
                        //   image: discos[index].banner, // URL de la imagen
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
                        // )),
                        // Título en la parte inferior
                        Positioned(
                          bottom: 10,
                          left: 10,
                          // right: 0,
                          child: Text(
                            discos[index].name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Boldfinger',
                              // fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CarouselItem {
  final String imageUrl;
  final String title;
  final String direccion;

  CarouselItem(
      {required this.imageUrl, required this.title, required this.direccion});
}
