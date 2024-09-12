import 'package:flutter/material.dart';

class DurationField extends StatelessWidget {
  final TextEditingController controller;

  const DurationField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Duration (minutes)'),
      keyboardType: TextInputType.number,
      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
    );
  }
}