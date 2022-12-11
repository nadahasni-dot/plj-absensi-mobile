import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    Key? key,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  final String hint;
  final Function(String query) onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.8,
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,        
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: primaryColor,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
