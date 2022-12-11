import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

import '../../../../widgets/primary_button.dart';
import '../../../../widgets/custom_outlined_button.dart';

class RejectDialog extends StatefulWidget {
  const RejectDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onReject,
  }) : super(key: key);

  final String title;
  final String description;
  final Function(String message) onReject;

  @override
  State<RejectDialog> createState() => _RejectDialogState();
}

class _RejectDialogState extends State<RejectDialog> {
  final _inputAlasan = TextEditingController();

  bool isValidated = false;
  final _formKey = GlobalKey<FormState>();

  void _validateForm() {
    bool valueValidated = true;
    final message = _inputAlasan.text.trim();

    if (message.isEmpty) {
      valueValidated = false;
    }

    setState(() {
      isValidated = valueValidated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: textDarkColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    minLines: 4,
                    maxLines: 6,
                    controller: _inputAlasan,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      fontSize: 14,
                      color: black,
                    ),
                    decoration: InputDecoration(
                      label: const Text('Alasan Penolakan'),
                      hintText: widget.description,
                    ),
                    onChanged: (value) {
                      _validateForm();
                    },
                    validator: (value) {
                      final alasan = value ?? '';
                      if (alasan.isEmpty) {
                        return 'Harap masukkan alasan penolakan';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomOutlinedButton(
                          onPressed: () => Get.back(),
                          label: 'Batal',
                          isDense: true,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: PrimaryButton(
                          enabled: isValidated,
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;

                            Get.back();
                            widget.onReject(_inputAlasan.text.trim());
                          },
                          label: 'Simpan',
                          isDense: true,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
