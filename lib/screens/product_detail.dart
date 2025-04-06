import 'package:flutter/material.dart';
import '../utils/custom_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping/models/product_model.dart';
import 'package:online_bike_shopping/constants/custom_colors.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key, required this.product, required this.heroImageTag});
  final ProductModel product;
  final String heroImageTag;
  final ValueNotifier _selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: TrianglePainter(),
          ).fadeInSlideLeft(),
          Positioned.fill(
            top: -450.h,
            child: Hero(
              tag: heroImageTag,
              child: Image.asset(
                product.image!,
                width: MediaQuery.of(context).size.width * 0.9,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 44.h,
                        width: 44.w,
                        margin: EdgeInsets.only(left: 20.w),
                        decoration: BoxDecoration(
                          gradient: CustomColors.gradient,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/chevron_left.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    SizedBox(width: 56.w),
                    Text(
                      product.modelName!,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: GradientBoxBorder(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.black.withOpacity(0.2)
                        ])),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r)),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF353F54), Color(0xFF222834)],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 32.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: ValueListenableBuilder(
                          valueListenable: _selectedIndex,
                          builder: (context, value, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                popButton(
                                        text: 'Description',
                                        index: 0,
                                        ontap: () => _selectedIndex.value = 0)
                                    .scaleAnimation(),
                                popButton(
                                        text: 'Specification',
                                        index: 1,
                                        ontap: () => _selectedIndex.value = 1)
                                    .scaleAnimation(
                                        delay:
                                            const Duration(milliseconds: 300)),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          product.modelName!,
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ).fadeInSlideUp(),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          product.description!,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.6)),
                        ).fadeInSlideUp(
                            delay: const Duration(milliseconds: 300)),
                      ),
                      SizedBox(height: 24.h),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF262E3D),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.r),
                              topRight: Radius.circular(50.r)),
                          border: GradientBoxBorder(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.black.withOpacity(0.2)
                              ],
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 25.h, horizontal: 35.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.price!,
                              style: TextStyle(
                                color: const Color(0xFF3D9CEA),
                                fontSize: 24.sp,
                              ),
                            ),
                            Container(
                              width: 160.w,
                              height: 44.h,
                              decoration: BoxDecoration(
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFF0FA9E5)
                                            .withOpacity(0.6),
                                        const Color.fromARGB(255, 14, 77, 194)
                                            .withOpacity(0.6)
                                      ],
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                  gradient: CustomColors.gradient),
                              child: const Center(
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget popButton(
      {required String text,
      required int index,
      required GestureTapCallback ontap}) {
    bool isSelected = index == _selectedIndex.value;

    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 133.w,
        height: 43.h,
        decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFF323B4F) : const Color(0xFF28303F),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      offset: Offset(-4, -4),
                      color: Color(0xFF38445A),
                      blurRadius: 10,
                    ),
                    const BoxShadow(
                      offset: Offset(4, 4),
                      color: Color(0xFF252B39),
                      blurRadius: 10,
                    ),
                  ]
                : [
                    const BoxShadow(
                      offset: Offset(-4, -4),
                      color: Color(0xFF364055),
                      blurRadius: 8,
                      spreadRadius: -12.0,
                    ),
                    const BoxShadow(
                      offset: Offset(4, 4),
                      color: Color(0xFF202633),
                      blurRadius: 8,
                      spreadRadius: -12.0,
                    ),
                  ]),
        child: Center(
          child: Text(
            text,
            style: isSelected
                ? const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.35,
                    color: CustomColors.skyBlue)
                : TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.35,
                    color: Colors.white.withOpacity(0.6)),
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = CustomColors.gradient
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(50.w, size.height);
    path.lineTo(size.width + 800.w, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
