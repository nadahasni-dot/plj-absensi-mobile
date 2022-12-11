import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/data/repositories/auth_repository.dart';
import 'package:plj_absensi_mobile/widgets/loading_dialog.dart';

class SignInController extends GetxController {
  Future<bool> login({required String email, required String password}) async {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);
    try {
      await AuthRepository.login(email: email, password: password);
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      Get.until((route) => !Get.isDialogOpen!);
      return false;
    }
  }
}
