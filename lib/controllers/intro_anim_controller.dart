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
  late final Animation<double> headingFade;
  late final Animation<Offset> headingSlide;
  late final Animation<double> subheadingFade;
  late final Animation<Offset> subheadingSlide;
  late final Animation<double> chipsFade;
  late final Animation<Offset> chipsSlide;
  late final Animation<double> ctaFade;
  late final Animation<Offset> ctaSlide;
  late final Animation<double> statsFade;
  late final Animation<Offset> statsSlide;

  /// Configure durations per screen
  IntroAnimController({
    Duration backDuration = const Duration(milliseconds: 500),
    Duration logoDuration = const Duration(milliseconds: 720),
    Duration contentDuration = const Duration(milliseconds: 1100),
  }) {
    backCtrl = AnimationController(vsync: this, duration: backDuration);
    backFade = CurvedAnimation(parent: backCtrl, curve: Curves.easeOut);
    backSlide = Tween<Offset>(begin: const Offset(-0.4, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: backCtrl, curve: Curves.easeOutCubic));

    logoCtrl = AnimationController(vsync: this, duration: logoDuration);
    logoFlip = CurvedAnimation(parent: logoCtrl, curve: Curves.easeOutBack);

    contentCtrl = AnimationController(vsync: this, duration: contentDuration);
    contentFade = CurvedAnimation(parent: contentCtrl, curve: Curves.easeOut);
    contentSlide = _slideInterval(0, 0.35, offset: const Offset(0, 0.12));

    headingFade = _interval(0.05, 0.35);
    headingSlide = _slideInterval(0.05, 0.35);

    subheadingFade = _interval(0.15, 0.45);
    subheadingSlide = _slideInterval(0.15, 0.45);

    chipsFade = _interval(0.32, 0.7);
    chipsSlide = _slideInterval(0.32, 0.7, offset: const Offset(0, 0.18));

    ctaFade = _interval(0.55, 0.85);
    ctaSlide = _slideInterval(0.55, 0.85, offset: const Offset(0, 0.22));

    statsFade = _interval(0.78, 1);
    statsSlide = _slideInterval(0.78, 1, offset: const Offset(0, 0.18));
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

  Animation<double> _interval(double begin, double end, {Curve curve = Curves.easeOut}) {
    return CurvedAnimation(parent: contentCtrl, curve: Interval(begin, end, curve: curve));
  }

  Animation<Offset> _slideInterval(double begin, double end, {Offset offset = const Offset(0, 0.16)}) {
    return Tween<Offset>(begin: offset, end: Offset.zero)
        .animate(CurvedAnimation(parent: contentCtrl, curve: Interval(begin, end, curve: Curves.easeOutCubic)));
  }

  Animation<double> intervalAnimation(double begin, double end, {Curve curve = Curves.easeOut}) {
    return _interval(begin, end, curve: curve);
  }

  Animation<Offset> slideAnimation(double begin, double end, {Offset offset = const Offset(0, 0.16)}) {
    return _slideInterval(begin, end, offset: offset);
  }

  double intervalValue(double begin, double end, {Curve curve = Curves.easeOut}) {
    final t = contentCtrl.value;
    if (t <= begin) return 0;
    if (t >= end) return 1;
    final normalized = ((t - begin) / (end - begin)).clamp(0.0, 1.0);
    return curve.transform(normalized);
  }

  @override
  void onClose() {
    backCtrl.dispose();
    logoCtrl.dispose();
    contentCtrl.dispose();
    super.onClose();
  }
}
