import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injection/injection.dart';
import '../../../../../config/theme/my_themes.dart';
import '../../../../../domain/models/discoteca_model.dart';
import '../../../../blocs/disco/disco_bloc.dart';

class AutocompleteCustom extends StatefulWidget {
  final String search;
  final List<Discoteca> discotecas;
  // Otras propiedades como dirección, logo, etc.
  const AutocompleteCustom(
      {super.key, required this.search, required this.discotecas});

  @override
  _AutocompleteCustomState createState() => _AutocompleteCustomState();
}

class _AutocompleteCustomState extends State<AutocompleteCustom> {
  final TextEditingController searchTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final discoBloc = getIt.get<DiscoBloc>();

    return BlocBuilder<DiscoBloc,DiscoState>(
      builder: (context, stateDisco) {
  
          return Autocomplete<Discoteca>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              // Filtrar el arreglo según lo que el usuario escriba
              if (textEditingValue.text.isEmpty) {
                return const Iterable<Discoteca>.empty();
              }

              return widget.discotecas.where((Discoteca discoteca) {
                return discoteca.name!
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            displayStringForOption: (Discoteca discoteca) => discoteca.name!,
            onSelected: (Discoteca discoteca) {
              discoBloc.add(DiscosFilterEvent(discoteca.name, '', ''));
              // Acciones al seleccionar una discoteca (por ejemplo, mostrar detalles)
              print('Discoteca seleccionada: ${discoteca.name}');
            },
            fieldViewBuilder:
                (context, controller, focusNode, onFieldSubmitted) {
              return TextFormField(
                onChanged: (e) => {
                  print('DISCOS:'),
                  discoBloc.add(DiscosFilterEvent(e, '', ''))
                },
                controller: controller,
                focusNode: focusNode,
                style: const TextStyle(
                  fontSize: 17,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  hoverColor: Theme.of(context).canvasColor.withOpacity(0.2),
                  hintText: 'Buscar tu discoteca',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                ),
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(
                    20.0), // Bordes redondeados opcionales
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 10.0, sigmaY: 10.0), // Efecto de desenfoque
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (theme.scaffoldBackgroundColor.value ==
                                whiteColor.value)
                            ? Colors.white.withOpacity(0.6)
                            : Colors.black.withOpacity(0.6)),
                    width: 300,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Discoteca option = options.elementAt(index);
                        return ListTile(
                          title: Text(
                            option.name!,
                            style: TextStyle(
                                color: (theme.scaffoldBackgroundColor.value ==
                                        whiteColor.value)
                                    ? primaryColor
                                    : whiteColor),
                          ),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
      },
    );
  }
}
