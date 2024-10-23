List<String> provinciasEspana = [
  'Álava',
  'Albacete',
  'Alicante',
  'Almería',
  'Asturias',
  'Ávila',
  'Badajoz',
  'Barcelona',
  'Burgos',
  'Cáceres',
  'Cádiz',
  'Cantabria',
  'Castellón',
  'Ceuta',
  'Ciudad Real',
  'Córdoba',
  'Cuenca',
  'Girona',
  'Granada',
  'Guadalajara',
  'Guipúzcoa',
  'Huelva',
  'Huesca',
  'Illes Balears',
  'Jaén',
  'La Coruña',
  'La Rioja',
  'Las Palmas',
  'León',
  'Lleida',
  'Lugo',
  'Madrid',
  'Málaga',
  'Melilla',
  'Murcia',
  'Navarra',
  'Ourense',
  'Palencia',
  'Pontevedra',
  'Salamanca',
  'Santa Cruz de Tenerife',
  'Segovia',
  'Sevilla',
  'Soria',
  'Tarragona',
  'Teruel',
  'Toledo',
  'Valencia',
  'Valladolid',
  'Vizcaya',
  'Zamora',
  'Zaragoza'
];

Map<String, List<String>> provinces = {
  'Álava': ['Vitoria-Gasteiz', 'Llodio', 'Amurrio'],
  'Albacete': ['Albacete', 'Hellín', 'Villarrobledo'],
  'Alicante': ['Alicante', 'Elche', 'Benidorm'],
  'Almería': ['Almería', 'Roquetas de Mar', 'El Ejido'],
  'Asturias': ['Oviedo', 'Gijón', 'Avilés'],
  'Ávila': ['Ávila', 'Arévalo', 'Cebreros'],
  'Badajoz': ['Badajoz', 'Mérida', 'Zafra'],
  'Barcelona': ['Barcelona', 'Hospitalet de Llobregat', 'Badalona'],
  'Burgos': ['Burgos', 'Miranda de Ebro', 'Aranda de Duero'],
  'Cáceres': ['Cáceres', 'Plasencia', 'Trujillo'],
  'Cádiz': ['Cádiz', 'Jerez de la Frontera', 'Algeciras'],
  'Cantabria': ['Santander', 'Torrelavega', 'Castro-Urdiales'],
  'Castellón': ['Castellón de la Plana', 'Villarreal', 'Burriana'],
  'Ceuta': ['Ceuta'],
  'Ciudad Real': ['Ciudad Real', 'Puertollano', 'Tomelloso'],
  'Córdoba': ['Córdoba', 'Lucena', 'Puente Genil'],
  'Cuenca': ['Cuenca', 'Tarancón', 'San Clemente'],
  'Girona': ['Girona', 'Figueres', 'Blanes'],
  'Granada': ['Granada', 'Motril', 'Almuñécar'],
  'Guadalajara': ['Guadalajara', 'Azuqueca de Henares', 'Cabanillas del Campo'],
  'Guipúzcoa': ['San Sebastián', 'Irún', 'Eibar'],
  'Huelva': ['Huelva', 'Lepe', 'Almonte'],
  'Huesca': ['Huesca', 'Barbastro', 'Monzón'],
  'Illes Balears': ['Palma de Mallorca', 'Ibiza', 'Manacor'],
  'Jaén': ['Jaén', 'Linares', 'Úbeda'],
  'La Coruña': ['La Coruña', 'Santiago de Compostela', 'Ferrol'],
  'La Rioja': ['Logroño', 'Calahorra', 'Haro'],
  'Las Palmas': ['Las Palmas de Gran Canaria', 'Telde', 'Arrecife'],
  'León': ['León', 'Ponferrada', 'San Andrés del Rabanedo'],
  'Lleida': ['Lleida', 'Balaguer', 'Tàrrega'],
  'Lugo': ['Lugo', 'Monforte de Lemos', 'Viveiro'],
  'Madrid': ['Madrid', 'Alcalá de Henares', 'Getafe'],
  'Málaga': ['Málaga', 'Marbella', 'Fuengirola'],
  'Melilla': ['Melilla'],
  'Murcia': ['Murcia', 'Cartagena', 'Lorca'],
  'Navarra': ['Pamplona', 'Tudela', 'Estella'],
  'Ourense': ['Ourense', 'O Barco de Valdeorras', 'Verín'],
  'Palencia': ['Palencia', 'Guardo', 'Aguilar de Campoo'],
  'Pontevedra': ['Vigo', 'Pontevedra', 'Vilagarcía de Arousa'],
  'Salamanca': ['Salamanca', 'Béjar', 'Ciudad Rodrigo'],
  'Santa Cruz de Tenerife': [
    'Santa Cruz de Tenerife',
    'San Cristóbal de La Laguna',
    'Arona'
  ],
  'Segovia': ['Segovia', 'Cuéllar', 'San Ildefonso'],
  'Sevilla': ['Sevilla', 'Dos Hermanas', 'Alcalá de Guadaíra'],
  'Soria': ['Soria', 'Almazán', 'El Burgo de Osma'],
  'Tarragona': ['Tarragona', 'Reus', 'Vendrell'],
  'Teruel': ['Teruel', 'Alcañiz', 'Andorra'],
  'Toledo': ['Toledo', 'Talavera de la Reina', 'Illescas'],
  'Valencia': ['Valencia', 'Gandía', 'Torrent'],
  'Valladolid': ['Valladolid', 'Medina del Campo', 'Laguna de Duero'],
  'Vizcaya': ['Bilbao', 'Barakaldo', 'Getxo'],
  'Zamora': ['Zamora', 'Benavente', 'Toro'],
  'Zaragoza': ['Zaragoza', 'Calatayud', 'Utebo'],
};

List<String> obtenerCiudadesPorProvincia(String? provincia) {
  // Validar si la provincia es nula o está vacía
  if (provincia == '') {
    return []; // O puedes devolver una lista vacía si prefieres
  }
  // Devolver la lista de ciudades si la provincia existe en el mapa
  return provinces[provincia] ?? [];
}
