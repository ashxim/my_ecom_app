import 'dart:math';
import 'package:flutter/material.dart';

class BubbleBackground extends StatelessWidget {
  final int bubbleCount;

  const BubbleBackground({super.key, this.bubbleCount = 7});

  List<Bubble> _generateBubbles() {
    final random = Random();
    List<Bubble> bubbles = [];

    for (int i = 0; i < bubbleCount; i++) {
      bubbles.add(
        Bubble(
          x: random.nextDouble(), // Random position across the width
          y: random.nextDouble(), // Random position across the height
          radius:
              random.nextDouble() * 30 + 20, // Radius between 20 and 50 pixels
          // Randomly choose a primary color and apply opacity
          color: Colors.primaries[random.nextInt(Colors.primaries.length)]
              .withOpacity(0.3),
        ),
      );
    }

    return bubbles;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // Let the CustomPaint fill its parent.
      size: Size.infinite,
      painter: BubblePainter(bubbles: _generateBubbles()),
    );
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;

  BubblePainter({required this.bubbles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      final paint = Paint()..color = bubble.color;
      // Convert normalized position to actual canvas coordinates.
      final offset = Offset(bubble.x * size.width, bubble.y * size.height);
      canvas.drawCircle(offset, bubble.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Bubble {
  final double x; // Normalized x (0.0 - 1.0)
  final double y; // Normalized y (0.0 - 1.0)
  final double radius; // In pixels
  final Color color;

  Bubble({
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
  });
}
