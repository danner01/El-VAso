import 'package:flutter/material.dart';

class CustomSelect<T> extends StatefulWidget {
  final List<T> list;
  final String? title;
  final String? labelText;
  final Function(T?) onChange;
  final T? initialValue;
  final String Function(T) displayString;
  final String? Function(T?)? validator;

  const CustomSelect({
    super.key,
    required this.list,
    this.title,
    required this.onChange,
    required this.displayString,
    this.validator,
    this.labelText,
    this.initialValue,
  });

  @override
  State<CustomSelect> createState() => _CustomSelectState<T>();
}

class _CustomSelectState<T> extends State<CustomSelect<T>> {
  T? _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.initialValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color textColor = theme.textTheme.bodyLarge!.color!;

    return DropdownButtonFormField<T>(
      value: _selectedItem,
      dropdownColor: Colors.white,
      onChanged: (T? newValue) {
        setState(() {
          _selectedItem = newValue;
          widget.onChange(newValue);
          // print('KKKK:${_selectedItem}');
        });
      },
  
      items: widget.list.map((T value) {
        final text = widget.displayString(value);
        return DropdownMenuItem<T>(
          value: value,
          child: Text(text),
        );
      }).toList(),
      
      isExpanded: true,
      decoration: InputDecoration(
        labelText: widget.labelText ?? '',
        labelStyle: TextStyle(color: theme.primaryColor),
        filled: true,
        fillColor: theme.colorScheme.surface.withAlpha(180),
        hoverColor: theme.primaryColor.withOpacity(0.2),
        focusColor: Colors.green,
        hintStyle: TextStyle(
          color: textColor.withOpacity(0.5),
          fontWeight: FontWeight.w300,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: theme.primaryColor.withOpacity(0.5),
          ),
        ),
      ),
      validator: widget.validator,
      selectedItemBuilder: (BuildContext context) {
        return widget.list.map<Widget>((T value) {
          final text = widget.displayString(value);
          return Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                text,
                style: TextStyle(color: textColor),
              ),
            ),
          );
        }).toList();
      },
    );
  }
}
