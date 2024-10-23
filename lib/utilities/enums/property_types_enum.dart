import 'package:flutter/material.dart';

enum PropertyTypes {
  none,
  apartamento,
  casa,
}

extension PropertyTypesExtension on PropertyTypes {
  String get title {
    switch (this) {
      case PropertyTypes.apartamento:
        return 'Apartamento';
      case PropertyTypes.casa:
        return 'Casa';
      default:
        return '-';
    }
  }

  IconData get icon {
    switch (this) {
      case PropertyTypes.apartamento:
        return Icons.business_outlined;
      case PropertyTypes.casa:
        return Icons.home;
      default:
        return Icons.mic_none;
    }
  }
}
