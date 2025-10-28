import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroAnimController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController backCtrl;
  late final Animation<double> backFade;
  late final Animation<Offset> backSlide;

  late final AnimationController logoCtrl;
  late final Animation<double> logoFlip; // 0..1 we will map to 0..pi

  late final AnimationController contentCtrl;
  late final Animation<double> contentFade;
  late final Animation<Offset> contentSlide;

  /// Configure durations per screen
  IntroAnimController({
    Duration backDuration = const Duration(milliseconds: 500),
    Duration logoDuration = const Duration(milliseconds: 700),
    Duration contentDuration = const Duration(milliseconds: 600),
  }) {
    backCtrl = AnimationController(vsync: this, duration: backDuration);
    backFade = CurvedAnimation(parent: backCtrl, curve: Curves.easeOut);
    backSlide = Tween<Offset>(begin: const Offset(-0.4, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: backCtrl, curve: Curves.easeOutCubic));

    logoCtrl = AnimationController(vsync: this, duration: logoDuration);
    logoFlip = CurvedAnimation(parent: logoCtrl, curve: Curves.easeOutBack);

    contentCtrl = AnimationController(vsync: this, duration: contentDuration);
    contentFade = CurvedAnimation(parent: contentCtrl, curve: Curves.easeOut);
    contentSlide = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(CurvedAnimation(parent: contentCtrl, curve: Curves.easeOutCubic));
  }

  /// call to start animations in sequence
  Future<void> playIn({bool showBack = false}) async {
    if (showBack) backCtrl.forward();
    await logoCtrl.forward();
    // slight overlap for nicer feel
    await Future.wait([
      contentCtrl.forward(),
    ]);
  }

  /// helper to get rotation angle for the flip (0..pi)
  double get logoRadians => logoFlip.value * math.pi;

  @override
  void onClose() {
    backCtrl.dispose();
    logoCtrl.dispose();
    contentCtrl.dispose();
    super.onClose();
  }
}
