import 'package:get/get.dart';

class AuthController extends GetxController {
  var isprofileloading = false.obs;
  RxString imageUrl = RxString('');

  void setIsProfileLoading(bool isLoading) {
    isprofileloading.value = isLoading;
  }
}
