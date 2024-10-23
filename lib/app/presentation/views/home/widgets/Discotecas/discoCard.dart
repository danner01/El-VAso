import 'package:el_vaso/app/config/theme/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../../../../../domain/models/discoteca_model.dart';


class DiscoCard extends StatelessWidget {
  const DiscoCard({
    super.key,
    required this.disco,
  });

  final Discoteca disco;

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
             disco.banner!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            //     FadeInImage.assetNetwork(
            //   placeholder:
            //       'assets/img/image_placeholder.png', // Imagen de placeholder (local o asset)
            //   image: disco.banner, // URL de la imagen
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

          // Título en la parte inferior
          Positioned(
            bottom: 30,
            left: 15,
            child: Text(
              disco.name!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontFamily: 'Boldfinger',
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/location_on.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                // ScrollingText(text: disco.address)
                Text(
                  disco.address!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 15,
            right: 15,
            child: LikeButton(
              bubblesColor: const BubblesColor(
                  dotPrimaryColor: primaryColor, dotSecondaryColor: whiteColor),
              likeBuilder: (isLiked) => isLiked
                  ? Icon(
                      Icons.favorite_rounded,
                      color: Colors.pink[600],
                    )
                  : const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
              // likeCount: 100,
            ),
            // Image.asset(
            //   'assets/icons/like.png',
            //   width: 20,
            //   height: 20,
            //   fit: BoxFit.fill,
            // ),
          ),
        ],
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
