import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping/widgets/product_cards.dart';
import 'package:online_bike_shopping/constants/product_data.dart';
import 'package:online_bike_shopping/constants/custom_colors.dart';
import 'package:online_bike_shopping/utils/custom_animations.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ValueNotifier<int> selectedTabIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(color: Colors.transparent),
          ),
        ),
        title: Text(
          "Choose Your Bike",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            height: 44.h,
            width: 44.w,
            margin: EdgeInsets.only(right: 20.w),
            decoration: BoxDecoration(
              gradient: CustomColors.gradient,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              fit: BoxFit.scaleDown,
            ),
          )
        ], 
      ),
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: TrianglePainter(),
          ).fadeInSlideLeft(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 24.h),
                    ClipPath(
                      clipper: SlantClipper(),
                      child: Container(
                        height: 240.h,
                        decoration: BoxDecoration(
                          border: GradientBoxBorder(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFFFFFFF).withOpacity(0.2),
                                const Color(0xFF000000).withOpacity(0.2),
                                const Color(0xFF000000).withOpacity(0.2),
                              ],
                              stops: const [0.0, 0.84, 1.0],
                            ),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF353F54).withOpacity(0.6),
                              const Color(0xFF222834).withOpacity(0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 20.h),
                                blurRadius: 20,
                                color: const Color(0xFF10141C).withOpacity(0.6))
                          ],
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  top: -40.h,
                                  child: Image.asset(
                                    'assets/images/cycle_1.png',
                                    fit: BoxFit.contain,
                                  ),
                                ).fadeInSlideUp(
                                    delay: const Duration(milliseconds: 300)),
                                Positioned(
                                  bottom: 20.h,
                                  left: 16.w,
                                  child: Text(
                                    '30% Off',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26.sp,
                                        color: Colors.white.withOpacity(0.6)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ).fadeInSlideUp(),
                    SizedBox(
                      height: 80.h,
                      child: ValueListenableBuilder(
                        valueListenable: selectedTabIndex,
                        builder: (context, value, child) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 10.w,
                                top: 26.h,
                                child: smallTabs(
                                  child: Text(
                                    "All",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  index: 0,
                                  onTap: () => selectedTabIndex.value = 0,
                                ),
                              ).fadeInSlideUp(),
                              Positioned(
                                left: 80.w,
                                top: 16.h,
                                child: smallTabs(
                                  child: SvgPicture.asset(
                                      'assets/icons/battery.svg'),
                                  index: 1,
                                  onTap: () => selectedTabIndex.value = 1,
                                ),
                              ).fadeInSlideUp(
                                  delay: const Duration(milliseconds: 100)),
                              Positioned(
                                left: 150.w,
                                top: 8.h,
                                child: smallTabs(
                                  child:
                                      SvgPicture.asset('assets/icons/road.svg'),
                                  index: 2,
                                  onTap: () => selectedTabIndex.value = 2,
                                ),
                              ).fadeInSlideUp(
                                  delay: const Duration(milliseconds: 200)),
                              Positioned(
                                right: 80.w,
                                top: -4.h,
                                child: smallTabs(
                                  child: SvgPicture.asset(
                                      'assets/icons/mountains.svg'),
                                  index: 3,
                                  onTap: () => selectedTabIndex.value = 3,
                                ),
                              ).fadeInSlideUp(
                                  delay: const Duration(milliseconds: 300)),
                              Positioned(
                                right: 10.w,
                                top: -14.h,
                                child: smallTabs(
                                  child: SvgPicture.asset(
                                      'assets/icons/helmet_2.svg'),
                                  index: 4,
                                  onTap: () => selectedTabIndex.value = 4,
                                ),
                              ).fadeInSlideUp(
                                  delay: const Duration(milliseconds: 400)),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 20.w,
                      children: [
                        for (int index = 0; index < productList.length; index++)
                          ProductCards(
                            product: productList[index],
                            heroImageTag: '__product_image_${index}__',
                          ).fadeInSlideUp(
                              delay:
                                  Duration(milliseconds: 100 * (index % 10))),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget smallTabs(
      {required Widget child,
      required int index,
      required GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFFFFFF).withOpacity(0.2),
                const Color(0xFF000000).withOpacity(0.2),
                const Color(0xFF000000).withOpacity(0.2),
              ],
              stops: const [0.0, 0.84, 1.0],
            ),
          ),
          gradient: LinearGradient(
            colors: index == selectedTabIndex.value
                ? [const Color(0xFF34C8E8), const Color(0xFF4E4AF2)]
                : [const Color(0xFF353F54), const Color(0xFF222834)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class SlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double roundnessFactor = 20.r;
    double slantHeight = 40.h;
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height - slantHeight);
    path.quadraticBezierTo(size.width, size.height - slantHeight, size.width,
        size.height - slantHeight - roundnessFactor);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = CustomColors.gradient
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(size.width - 100.w, 180.h);
    path.lineTo(0, size.height);
    path.lineTo(size.width + 800.w, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
