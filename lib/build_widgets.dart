import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  String? text;
  VoidCallback? ontap;
  final bool loading;
  BuildButton({
    required this.text,
    required this.ontap,
    this.loading = false,
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 40,
        width: width * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 19, 160, 216)),
        child: Center(
            child: loading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    text.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  )),
      ),
    );
  }
}

// Sign UP textfield
class textformfield extends StatelessWidget {
  String? Function(String?)? validatr;
  Function(String)? onchange;
  String? hint;
  var maxlines;
  Widget? prefix, suffix;
  var obsecure;
  TextEditingController textcontroller;
  textformfield({
    this.hint,
    required this.textcontroller,
    this.validatr,
    this.onchange,
    this.maxlines,
    this.prefix,
    this.obsecure = false,
    this.suffix,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        maxLines: maxlines,
        controller: textcontroller,
        obscureText: obsecure,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: prefix,
          suffixIcon: suffix,
          hintText: hint.toString(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 19, 160, 216)),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        validator: validatr,
        onChanged: onchange,
      ),
    );
  }
}
