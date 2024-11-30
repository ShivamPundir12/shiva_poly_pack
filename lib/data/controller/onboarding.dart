import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  // Observable to track the current index
  var currentIndex = 0.obs;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    // timer = Timer.periodic(Duration(milliseconds: 2800), (c) {
    //   if (currentIndex < 2) {
    //     pageController.nextPage(
    //         duration: Durations.medium2, curve: Curves.decelerate);
    //     currentIndex++;
    //   } else if (currentIndex != 0) {
    //     pageController.animateToPage(0,
    //         duration: Duration(milliseconds: 500), curve: Curves.ease);
    //   }
    //   update();
    // });
  }

  // PageController for the PageView
  final pageController = PageController();

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    timer.cancel();
    super.onClose();
  }
}
