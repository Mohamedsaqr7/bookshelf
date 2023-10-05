import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Features/Authentications/View/Register.dart';
import 'package:bookshelf/Features/onboarding/content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Animate(
        effects: [
          SlideEffect(
              curve: Curves.fastEaseInToSlowEaseOut,
              duration: Duration(seconds: 2)),
          ShimmerEffect(
              delay: Duration(seconds: 2), duration: Duration(seconds: 2)),
        ],
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, top: 30.h),
                    child: Column(
                      children: [
                        sbox(h: 30),
                        Image.asset(
                          contents[i].image ?? '',
                          height: 300,
                        ),
                        Text(
                          contents[i].title ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          contents[i].discription ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => Animate(
                      effects: [SlideEffect(duration: Duration(seconds: 1))],
                      child: buildDot(index, context)),
                ),
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomColors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      currentIndex == contents.length - 1 ? "Continue" : "Next",
                      style: TextStyle(color: Colors.white, fontSize: 25.sp),
                    ),
                  ),
                ),
                onTap: () {
                  if (currentIndex == contents.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Register(),
                      ),
                    );
                  }
                  _controller.nextPage(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeInOutQuart,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 30 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CustomColors.green,
      ),
    );
  }
}
