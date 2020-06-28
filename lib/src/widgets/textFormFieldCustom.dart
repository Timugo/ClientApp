import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final Icon text;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final List inputFormatters;
  final bool isEmail;

  MyTextFormField({
    this.text,
    this.hintText,
    this.validator,
    this.onSaved,
    this.inputFormatters,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.1,
          right: size.width * 0.1,
          bottom: 10,
          top: size.width * 0.05),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            prefixIcon: text,
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.0),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            )),
        validator: validator,
        onSaved: onSaved,
        inputFormatters: inputFormatters,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
