import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? ctr;
  final String title;
  final String hintText;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    this.ctr,
    required this.title,
    required this.hintText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        TextFormField(
          controller: ctr,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (value != null && value.isNotEmpty) return null;
            return 'Kiritish shart';
          },
        ),
      ],
    );
  }
}
