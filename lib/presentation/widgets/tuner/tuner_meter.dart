import 'package:flutter/material.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/colors.dart';
import 'dart:math' as math;

class TunerMeter extends StatelessWidget {
  final double cents;
  final bool isInTune;

  const TunerMeter({
    super.key,
    required this.cents,
    required this.isInTune,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: CustomPaint(
        painter: _TunerMeterPainter(
          cents: cents,
          isInTune: isInTune,
          context: context,
        ),
      ),
    );
  }
}

class _TunerMeterPainter extends CustomPainter {
  final double cents;
  final bool isInTune;
  final BuildContext context;

  _TunerMeterPainter({
    required this.cents,
    required this.isInTune,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height;
    final radius = size.width / 1.5;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // Draw scale ticks
    // Range is -50 to +50 cents
    // Angle range is -45 to +45 degrees (pi/4)
    const maxAngle = math.pi / 4;
    const maxCents = 50.0;

    for (int i = -50; i <= 50; i += 5) {
      final isMajor = i % 10 == 0;
      final isCenter = i == 0;
      
      final normalizedValue = i / maxCents;
      final angle = normalizedValue * maxAngle - math.pi / 2; // -pi/2 is 12 o'clock, so we simply rotate

      final tickLength = isCenter ? 20.0 : (isMajor ? 15.0 : 10.0);
      final tickColor = isCenter 
          ? (isInTune ? AppColors.tunerSuccess : Colors.white)
          : (isMajor ? Colors.white70 : Colors.white30);

      paint.color = tickColor;
      paint.strokeWidth = isCenter || isMajor ? 3.0 : 1.5;

      // Calculate start and end points for tick
      // We want ticks to be arranged in an arc
      
      final tickRadiusStart = radius;
      final tickRadiusEnd = radius - tickLength;

      final p1 = Offset(
        centerX + tickRadiusStart * math.cos(angle),
        centerY + tickRadiusStart * math.sin(angle)
      );
      
      final p2 = Offset(
        centerX + tickRadiusEnd * math.cos(angle),
        centerY + tickRadiusEnd * math.sin(angle)
      );

      canvas.drawLine(p1, p2, paint);
    }

    // Draw Needle
    // Clamp cents to range
    final clampedCents = cents.clamp(-50.0, 50.0);
    final needleAngle = (clampedCents / maxCents) * maxAngle - math.pi / 2;
    
    final needleColor = isInTune 
        ? AppColors.tunerSuccess 
        : (cents > 0 ? AppColors.tunerSharp : AppColors.tunerFlat);

    paint.color = needleColor;
    paint.strokeWidth = 5.0;
    
    final needleEndRadius = radius - 5;
    final needleStart = Offset(centerX, centerY);
    final needleEnd = Offset(
      centerX + needleEndRadius * math.cos(needleAngle),
      centerY + needleEndRadius * math.sin(needleAngle)
    );

    canvas.drawLine(needleStart, needleEnd, paint);

    // Draw Pivot
    paint.style = PaintingStyle.fill;
    paint.color = Colors.white;
    canvas.drawCircle(needleStart, 8.0, paint);
  }

  @override
  bool shouldRepaint(covariant _TunerMeterPainter oldDelegate) {
    return oldDelegate.cents != cents || oldDelegate.isInTune != isInTune;
  }
}
