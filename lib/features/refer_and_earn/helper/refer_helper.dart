import 'package:flutter_grocery/features/splash/providers/splash_provider.dart';
import 'package:flutter_grocery/main.dart';
import 'package:provider/provider.dart';


class ReferHelper {
  static String getSignUpLink(String referCode) {
    final SplashProvider splashProvider = Provider.of<SplashProvider>(Get.context!, listen: false);
    return 'Hello!,\nI\'m excited to indroduce you to FROSTY FOODS, your new go-to destination for healthy and chemical-free food products!\nTheir in-house facility top-notch quality, prioritizing your well-being without adding any harmful preservatives or chemicals.\nNew to FROSTY FOODS? Explore their app at ${splashProvider.configModel?.playStoreConfig?.link} and use my referral code "$referCode" during signup tp unlock exclusive benifits! \n\nJoin the healthy eating revolution with FROSTY FOODS!';
  }

}