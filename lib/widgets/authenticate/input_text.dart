import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputTextAuth extends StatefulWidget {
  InputTextAuth({ String? Function(String?)? validator, void Function(String?)? onSaved, bool? isPassword ,required this.icon,
    required this.hintText , TextEditingController? controller,super.key}):
        isPassword = isPassword ?? false,
        validator = validator ?? ((value) { return null;}),
        controller = controller ?? TextEditingController(),
        onSaved = onSaved ?? ((value) { return;});

  TextEditingController controller = TextEditingController();
  String hintText;
  IconData icon;
  bool? isPassword = false;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;

  @override
  State<InputTextAuth> createState() => _InputTextAuthState();
}

class _InputTextAuthState extends State<InputTextAuth> {

  @override
  void dispose() {
    widget.controller.dispose();
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
        obscureText: widget.isPassword!,
        decoration:  InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Padding(padding: const EdgeInsets.only(left: 22, right: 10), child: Icon(widget.icon)),
        ),
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
    );
  }
}
