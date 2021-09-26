import 'package:flutter/material.dart';

class TextFormFieldpage extends StatefulWidget {
  final String name;
  final String initialValue;
  final FormFieldSetter onsave;
  final TextInputType keybordtype;
  final FormFieldValidator<String> validator;
  const TextFormFieldpage(
      {Key? key,
      required this.name,
      required this.onsave,
      required this.validator, required this.initialValue, required this.keybordtype})
      : super(key: key);

  @override
  _TextFormFieldpageState createState() => _TextFormFieldpageState();
}

class _TextFormFieldpageState extends State<TextFormFieldpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: widget.keybordtype,
        initialValue: widget.initialValue,
        onSaved: widget.onsave,
        validator: widget.validator,
        decoration: InputDecoration(
          
            hintText: widget.name,
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[300],
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent))),
      ),
    );
  }
}
