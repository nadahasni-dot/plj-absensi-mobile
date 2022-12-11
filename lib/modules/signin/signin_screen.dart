import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';
import 'package:plj_absensi_mobile/modules/signin/controllers/sign_in_controller.dart';
import 'package:plj_absensi_mobile/routes/route_names.dart';
import 'package:plj_absensi_mobile/widgets/primary_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _controller = Get.put(SignInController());

  final _formKey = GlobalKey<FormState>();
  final _inputEmail = TextEditingController();
  final _inputPassword = TextEditingController();

  bool isValidated = false;
  bool isObsecure = true;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  _validateForm() {
    bool valueValidated = true;
    String email = _inputEmail.text.trim();
    String password = _inputPassword.text.trim();

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      valueValidated = false;
    }

    if (password.isEmpty) {
      valueValidated = false;
    }

    if (password.length < 6 || password.length > 16) {
      valueValidated = false;
    }

    setState(() {
      isValidated = valueValidated;
    });
  }

  void _doLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final isSuccess = await _controller.login(
      email: _inputEmail.text,
      password: _inputPassword.text,
    );

    if (isSuccess) Get.offAllNamed(RouteNames.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainLayerColor,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/logo.png',
          width: 88,
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
                "Selamat Datang Kembali",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "Masuk untuk melanjutkan",
                style: TextStyle(
                  fontSize: 16,
                  color: textDarkGreyColor,
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _inputEmail,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 14,
                  color: black,
                ),
                decoration: const InputDecoration(
                  label: Text('Email'),
                  hintText: 'Email',
                ),
                onChanged: (value) {
                  _validateForm();
                },
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !GetUtils.isEmail(value)) {
                    return 'Harap masukkan email yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _inputPassword,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obscureText: isObsecure,
                style: const TextStyle(
                  fontSize: 14,
                  color: black,
                ),
                decoration: InputDecoration(
                  label: const Text('Password'),
                  hintText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    child: Icon(isObsecure
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded),
                  ),
                ),
                onChanged: (value) {
                  _validateForm();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan password';
                  }

                  if (value.length < 6 || value.length > 16) {
                    return 'Password harus terdiri dari 6 - 16 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Masuk',
                enabled: isValidated,
                onPressed: _doLogin,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
