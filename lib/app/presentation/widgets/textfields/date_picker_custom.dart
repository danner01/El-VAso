import 'package:el_vaso/app/presentation/widgets/textfields/textfiled_custom.dart';
import 'package:flutter/material.dart';


// Aquí está tu DatePickerCustom basado en tu TextFieldCustom
class DatePickerCustom extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;

  const DatePickerCustom({
    super.key,
    this.hintText,
    this.labelText,
    this.initialDate,
    this.onDateSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DatePickerCustomState createState() => _DatePickerCustomState();
}

class _DatePickerCustomState extends State<DatePickerCustom> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _controller.text =
          "${widget.initialDate!.day}/${widget.initialDate!.month}/${widget.initialDate!.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldCustom(
      controller: _controller,
      hintText: widget.hintText,
      labelText: widget.labelText,
      textInputType: TextInputType.text,
      readOnly: true,
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: widget.initialDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          _controller.text = "${date.day}/${date.month}/${date.year}";
          if (widget.onDateSelected != null) {
            widget.onDateSelected!(date);
          }
        }
      },
      colorIcon: Colors.grey,
      icon: Icons.calendar_today,
    );
  }
}
