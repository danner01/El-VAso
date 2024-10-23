import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_constans.dart';
import 'no_items_found.dart';

class CusttomSearchAndSelect<T> extends StatelessWidget {
  final String title;
  final String? labelSearch;
  final T? initialValue;
  final List<T> list;
  final bool Function(T, T)? compareFn;
  final void Function(T?)? onChanged;
  // final String? Function(String? barrio)? validator;
  const CusttomSearchAndSelect({
    super.key,
    this.onChanged,
    // this.validator,
    required this.title,
    required this.list,
    this.initialValue,
    this.compareFn,
    this.labelSearch = 'Buscar',
    // this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hintText = Theme.of(context).textTheme.bodyMedium;

    final inputDecoration = InputDecoration(
      labelText: title,
      labelStyle: TextStyle(color: theme.primaryColor),
      prefixStyle: hintText!.copyWith(
        color: hintText.color!.withOpacity(0.5),
      ),
      filled: true,
      fillColor: theme.inputDecorationTheme.fillColor,
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.2),
      focusColor: Colors.green,
      hintStyle: const TextStyle(color: Colors.red),
      border: OutlineInputBorder(
        borderRadius: AppConstants.borderRadius,
      ),
      contentPadding: const EdgeInsets.only(left: 15),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: theme.primaryColor.withOpacity(0.5)),
      ),
      suffixIcon: const Icon(Icons.arrow_drop_down),
    );

    return DropdownSearch<T>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: inputDecoration,
      ),
      selectedItem: initialValue,
      items: list,
      onChanged: onChanged,
      compareFn: compareFn,
      popupProps: PopupPropsMultiSelection.modalBottomSheet(
        isFilterOnline: true,
        showSelectedItems: true,
        showSearchBox: true,
        emptyBuilder: (context, searchEntry) => const NoItemsFoundWidget(
          'No hay resultados',
          icon: Icons.search_off,
          iconColor: Colors.grey,
        ),
        searchDelay: const Duration(milliseconds: 0),
        searchFieldProps: TextFieldProps(
          decoration: inputDecoration.copyWith(
            labelText: labelSearch,
            suffixIcon: const Icon(Icons.search),
          ),
        ),
        itemBuilder: _customPopupItemBuilderExample2,
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context, T item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.toString()),
      ),
    );
  }
}
