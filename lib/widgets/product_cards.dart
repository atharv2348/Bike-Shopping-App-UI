import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping/models/product_model.dart';
import 'package:online_bike_shopping/screens/product_detail.dart';

class ProductCards extends StatelessWidget {
  ProductCards({super.key, required this.product, required this.heroImageTag});
  final ProductModel product;
  final ValueNotifier isLiked = ValueNotifier<bool>(false);
  final String heroImageTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              product: product,
              heroImageTag: heroImageTag,
            ),
          ),
        );
      },
      child: ClipPath(
        clipper: ProductCardClipper(),
        child: Container(
          height: 241.h,
          width: 165.w,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20.h),
                  blurRadius: 20,
                  color: const Color(0xFF10141C).withOpacity(0.2))
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF363E51).withOpacity(0.6),
                const Color(0xFF191E26).withOpacity(0.6),
              ],
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Stack(
              children: [
                Positioned.fill(
                  top: -80.h,
                  child: Hero(
                    tag: heroImageTag,
                    child: Image.asset(
                      colorBlendMode: BlendMode.colorBurn,
                      product.image!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 20.h,
                  right: 0,
                  child: ValueListenableBuilder(
                    valueListenable: isLiked,
                    builder: (context, value, child) => Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: ()=> isLiked.value = !isLiked.value,
                        child: SvgPicture.asset(
                          isLiked.value
                              ? 'assets/icons/selected_heart.svg'
                              : 'assets/icons/unselected_heart.svg',
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.productName!,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        product.modelName!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        product.price!,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    double roundnessFactor = 20.r;
    double slantHeight = 20.h;

    // top-left
    path.moveTo(0, roundnessFactor + slantHeight);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height - slantHeight);
    path.quadraticBezierTo(size.width, size.height - slantHeight, size.width,
        size.height - slantHeight - roundnessFactor);

    path.lineTo(size.width, roundnessFactor);
    path.quadraticBezierTo(size.width, 0, size.width - roundnessFactor, 0);
    path.lineTo(roundnessFactor, slantHeight);
    path.quadraticBezierTo(
      0,
      slantHeight,
      0,
      roundnessFactor + slantHeight,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
