import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultTextFormField extends StatelessWidget {
  @required
  String label;
  @required
  IconData iconData;
  @required
  TextEditingController controller;
  @required
  TextInputType type;
  @required
  Function onSubmitted;
  @required
  Function onSaved;
  @required
  Function validate;
  Function onTap;

  DefaultTextFormField({
    this.label,
    this.iconData,
    this.controller,
    this.type,
    this.onSubmitted,
    this.onSaved,
    this.validate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        keyboardType: type,
        controller: controller,
        onFieldSubmitted: onSubmitted,
        onSaved: onSaved,
        onTap: onTap,
        validator: validate,
      ),
    );
  }
}
