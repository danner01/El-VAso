import 'package:flutter/material.dart';

import '../../../../../config/theme/my_themes.dart';
import '../../../../widgets/buttons/custom_button.dart';
import '../input_decoration.dart';
import 'data.dart';

class DraggableScollCustom extends StatefulWidget {
  final Widget child;

  const DraggableScollCustom({super.key, required this.child});

  @override
  State<DraggableScollCustom> createState() => _DraggableScollCustomState();
}

class _DraggableScollCustomState extends State<DraggableScollCustom> {
  String? selectedProvince;
  String? selectedCity;
  List<String> cities = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8, // Altura inicial: 80% de la pantalla
      minChildSize: 0.2, // Tamaño mínimo al arrastrar
      maxChildSize: 0.9, // Tamaño máximo al arrastrar
      builder: (BuildContext context, ScrollController scrollController) {
        return ListView(
          controller: scrollController,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (Theme.of(context).scaffoldBackgroundColor.value ==
                            whiteColor.value)
                        ? textColor
                        : whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 50,
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fecha',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: (Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .value ==
                                  whiteColor.value)
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                      ),
                      widget.child,
                      Text(
                        'Provincia',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: (Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .value ==
                                  whiteColor.value)
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        alignment: AlignmentDirectional.centerStart,
                        style: TextStyle(
                          color: (theme.scaffoldBackgroundColor.value ==
                                  whiteColor.value)
                              ? textColor
                              : whiteColor,
                          fontSize: 16,
                        ),
                        hint: Text(
                          'Seleccionar provincia',
                          style: TextStyle(
                              color: textColor.withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                        ),
                        dropdownColor: theme.scaffoldBackgroundColor,
                        decoration: dropdownDecoration(context),
                        value: selectedProvince,
                        onChanged: (String? newProvince) {
                          setState(() {
                            selectedProvince = newProvince;
                            selectedCity =
                                null; // Reiniciar la ciudad seleccionada
                            cities = provinces[
                                selectedProvince]!; // Actualizar las ciudades
                          });
                        },
                        items: provinces.keys
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Ciudad',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: (Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .value ==
                                  whiteColor.value)
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Si no hay ciudades disponibles, mostramos un mensaje o una lista vacía
                      DropdownButtonFormField<String>(
                        style: TextStyle(
                          color: (theme.scaffoldBackgroundColor.value ==
                                  whiteColor.value)
                              ? textColor
                              : whiteColor,
                          fontSize: 16,
                        ),
                        dropdownColor: theme.scaffoldBackgroundColor,
                        hint: Text(
                          'Seleccionar ciudad',
                          style: TextStyle(
                              color: textColor.withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                        ),
                        decoration: dropdownDecoration(context),
                        value: selectedCity,
                        onChanged: (String? newCity) {
                          setState(() {
                            selectedCity = newCity;
                          });
                        },
                        items: cities
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              color: theme.scaffoldBackgroundColor,
                              textStyle: TextStyle(
                                  color: (theme.scaffoldBackgroundColor.value ==
                                          whiteColor.value)
                                      ? primaryColor
                                      : whiteColor),
                              borderRadius: 25,
                              text: 'Restablecer',
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CustomButton(
                              borderRadius: 25,
                              text: 'Aplicar Filtros',
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
