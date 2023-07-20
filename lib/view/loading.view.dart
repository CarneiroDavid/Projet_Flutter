import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ipssisqy2023/view/resgister_view.dart';
import 'package:lottie/lottie.dart';

class MyLoading extends StatefulWidget {
  const MyLoading({super.key});

  @override
  State<MyLoading> createState() => _MyLoadingState();
}

class _MyLoadingState extends State<MyLoading> {

  PageController pageController = PageController(initialPage: 0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      Navigator.push(context,MaterialPageRoute(
          builder : (context){
            dispose();
            return const MyRegisterView();
          }
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        children: [
          Center(
            child: Lottie.asset("assets/1.json"),
          ),
        ],
        controller: pageController,
      )
    );
  }
}
