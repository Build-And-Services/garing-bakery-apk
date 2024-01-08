import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputAuthWidget extends StatelessWidget {
  final String label;
  final String placeholder;
  String? Function(String?)? validation;
  bool obscure;
  TextEditingController? controller;

  InputAuthWidget({
    Key? key,
    required this.label,
    required this.placeholder,
    this.validation,
    this.obscure = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            color: Colors.grey[100],
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: TextFormField(
            validator: validation,
            obscureText: obscure,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: placeholder,
              contentPadding: const EdgeInsets.all(10),
              // icon: const Icon(Icons.email),
            ),
            controller: controller,
          ),
        ),
      ],
    );
  }
}
