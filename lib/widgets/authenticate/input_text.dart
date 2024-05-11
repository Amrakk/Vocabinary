import 'package:flutter/material.dart';

class InputTextAuth extends StatefulWidget {
  InputTextAuth({ this.label ,String? Function(String?)? validator, void Function(String?)? onSaved, bool? isPassword ,required this.icon,
    required this.hintText , this.controller,super.key}):
        isPassword = isPassword ?? false,
        validator = validator ?? ((value) { return null;}),
        onSaved = onSaved ?? ((value) { return;})
  ;

  TextEditingController? controller;
  String hintText;
  IconData icon;
  bool? isPassword = false;
  String? label;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;

  @override
  State<InputTextAuth> createState() => _InputTextAuthState();
}

class _InputTextAuthState extends State<InputTextAuth> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      elevation: 5,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: widget.controller,
        enabled: true,
        obscureText: widget.isPassword! ? _obscureText : false,
        decoration:  InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          prefixIcon: Padding(padding: const EdgeInsets.only(left: 22, right: 10), child: Icon(widget.icon)),
          suffixIcon: widget.isPassword! ? Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: _togglePasswordVisibility,
            ),
          ) : null,
        ),
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
    );
  }
}
