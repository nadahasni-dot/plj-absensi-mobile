import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/modules/akun/controllers/profile_controller.dart';
import 'package:plj_absensi_mobile/widgets/custom_outlined_button.dart';
import 'package:plj_absensi_mobile/widgets/primary_button.dart';

class AkunSayaScreen extends StatefulWidget {
  const AkunSayaScreen({Key? key}) : super(key: key);

  @override
  State<AkunSayaScreen> createState() => _AkunSayaScreenState();
}

class _AkunSayaScreenState extends State<AkunSayaScreen> {
  final _profileController = Get.find<ProfileController>();

  final _inputNip = TextEditingController();
  final _inputNama = TextEditingController();
  final _inputEmail = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isValidated = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  _loadInitialData() {
    final user = _profileController.user!;

    _inputNip.text = user.nip;
    _inputNama.text = user.name;
    _inputEmail.text = user.email;
  }

  void _validateForm() {
    bool valueValidated = true;
    final nip = _inputNip.text.trim();
    final nama = _inputNama.text.trim();
    final email = _inputEmail.text.trim();

    if (nip.isEmpty) {
      valueValidated = false;
    }

    if (nama.isEmpty) {
      valueValidated = false;
    }

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      valueValidated = false;
    }

    setState(() {
      isValidated = valueValidated;
    });
  }

  _doSaveAkun() {
    if (!isValidated) return;
    if (!_formKey.currentState!.validate()) return;

    _profileController.updateProfile(name: _inputNama.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainLayerColor,
      appBar: AppBar(
        title: const Text('Akun Saya'),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Data Diri',
                style: TextStyle(
                  fontSize: 18,
                  color: black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                enabled: false,
                readOnly: true,
                controller: _inputNip,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  fontSize: 14,
                  color: textDarkGreyColor,
                ),
                decoration: const InputDecoration(
                  label: Text('Nomor Induk Pegawai (NIP)'),
                  hintText: 'Nomor Induk Pegawai (NIP)',
                ),
                onChanged: (value) {
                  _validateForm();
                },
                // validator: (value) {
                //   final nip = value ?? '';
                //   if (nip.isEmpty) {
                //     return 'Harap masukkan nip yang valid';
                //   }
                //   if (nip.length != 16 || !nip.isNumericOnly) {
                //     return 'Harap masukkan nip yang valid';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _inputNama,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                ],
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  fontSize: 14,
                  color: black,
                ),
                decoration: const InputDecoration(
                  label: Text('Nama Lengkap'),
                  hintText: 'Nama Lengkap',
                ),
                onChanged: (value) {
                  _validateForm();
                },
                validator: (value) {
                  final nama = value ?? '';
                  if (nama.isEmpty) {
                    return 'Harap masukkan nama lengkap';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                enabled: false,
                readOnly: true,
                controller: _inputEmail,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 14,
                  color: textDarkGreyColor,
                ),
                decoration: const InputDecoration(
                  label: Text('Email'),
                  hintText: 'Email',
                ),
                onChanged: (value) {
                  _validateForm();
                },
                validator: (value) {
                  final email = value ?? '';
                  if (email.isEmpty || !GetUtils.isEmail(email)) {
                    return 'Harap masukkan email yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Simpan',
                enabled: isValidated,
                onPressed: _doSaveAkun,
              ),
              const SizedBox(height: 16),
              CustomOutlinedButton(
                label: 'Batal',
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
