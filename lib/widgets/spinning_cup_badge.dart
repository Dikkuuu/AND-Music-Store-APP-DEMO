import 'dart:math' as math;
import 'package:flutter/material.dart';

class SpinningCupBadge extends StatefulWidget {
  const SpinningCupBadge({super.key});

  @override
  State<SpinningCupBadge> createState() => _SpinningCupBadgeState();
}

class _SpinningCupBadgeState extends State<SpinningCupBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF262636),
          border: Border.fromBorderSide(
            BorderSide(color: Color(0xFFF59E0B), width: 1.2),
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          // Parameter child dipakai agar widget Icon statis tidak di-rebuild tiap frame
          child: const Icon(
            Icons.local_cafe_rounded,
            color: Color(0xFFF59E0B),
            size: 22,
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * math.pi,
              child: child,
            );
          },
        ),
      ),
    );
  }
}