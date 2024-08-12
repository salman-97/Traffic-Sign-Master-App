import 'package:flutter/material.dart';

class SlideRightPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final bool slideRight;

  SlideRightPageRoute({
    required this.page,
    required this.slideRight,
    Duration transitionDuration = const Duration(milliseconds: 800),
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const beginRight = Offset(1.0, 0.0);
            const endRight = Offset.zero;
            const beginLeft = Offset(-1.0, 0.0);
            const endLeft = Offset.zero;
            const curve = Curves.easeInOutQuint;

            var begin = slideRight ? beginRight : beginLeft;
            var end = slideRight ? endRight : endLeft;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
}
