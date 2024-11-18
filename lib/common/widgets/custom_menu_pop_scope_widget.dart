import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/common/widgets/custom_alert_dialog_widget.dart';
import 'package:flutter_grocery/features/splash/providers/splash_provider.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/localization/language_constraints.dart';
import 'package:flutter_grocery/utill/dimensions.dart';

class CustomMenuPopScopeWidget extends StatefulWidget {
  final SplashProvider splash;
  final Widget child;
  final Function()? onPopInvoked;
  const CustomMenuPopScopeWidget({Key? key, required this.child, this.onPopInvoked, required this.splash}) : super(key: key);

  @override
  State<CustomMenuPopScopeWidget> createState() => _CustomMenuPopScopeWidgetState();
}

class _CustomMenuPopScopeWidgetState extends State<CustomMenuPopScopeWidget> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: ResponsiveHelper.isWeb() ? true : Navigator.canPop(context),
      onPopInvoked: (didPop) {
        if(widget.onPopInvoked != null) {
          widget.onPopInvoked!();
        }

        if(!didPop) {
          if(widget.splash.pageIndex==0){
            ResponsiveHelper.showDialogOrBottomSheet(context, CustomAlertDialogWidget(
            title: getTranslated('close_the_app', context),
            subTitle: getTranslated('do_you_want_to_close_and', context),
            rightButtonText: getTranslated('exit', context),
            iconWidget: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
              child: const Padding(
                padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Icon(Icons.logout, color: Colors.white, size: 40),
              ),
            ),
            onPressRight: (){
              exit(0);
            },

          ));
          }else{
            widget.splash.setPageIndex(0);
          }
        }
      },
      child: widget.child,
    );
  }
}
