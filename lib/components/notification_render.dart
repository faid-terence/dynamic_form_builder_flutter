import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_form_generator/provider/updates_provider.dart';

class NotificationRender extends StatelessWidget {
  final String title;
  final String message;
  final DateTime date;
  final bool hasToPay;
  final String? paymentLink;
  final VoidCallback? onInfoPressed;
  final VoidCallback? onPayPressed;

  const NotificationRender({
    super.key,
    required this.title,
    required this.message,
    required this.date,
    this.hasToPay = false,
    this.paymentLink,
    this.onInfoPressed,
    this.onPayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdatesProvider>(
      builder: (context, provider, child) {
        final updates = provider.getUpdatesByTitle(title)
          ..sort((a, b) => _parseTime(b.date.toString())
              .compareTo(_parseTime(a.date.toString())));

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: () => Navigator.pop(context),
              color: Colors.black,
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.info_outline_rounded,
                  size: 22,
                  color: Colors.black,
                ),
                onPressed: onInfoPressed,
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey.shade200,
                height: 0.5,
              ),
            ),
          ),
          body: ListView(
            children: [
              const SizedBox(height: 16),
              // Yesterday divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 0.5,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Yesterday',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 0.5,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Messages
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: updates
                      .map((update) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Time stamp
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, bottom: 8),
                                child: Text(
                                  update.date.toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              // Message bubble
                              BubbleSpecialThree(
                                text: update.description,
                                color: const Color(0xFFF2F2F7),
                                isSender: false,
                                tail: !update.hasToPay,
                              ),
                              // Pay Now button if required
                              if (update.hasToPay)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 90, bottom: 24),
                                  child: CustomPaint(
                                    painter: BubbleButtonPainter(
                                      color: const Color(0xFFE6DDF7),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            if (update
                                                    .paymentLink?.isNotEmpty ??
                                                false) {
                                              Navigator.pushNamed(
                                                  context, update.paymentLink!);
                                            }
                                            onPayPressed?.call();
                                          },
                                          customBorder:
                                              const BubbleButtonBorder(),
                                          child: const Center(
                                            child: Text(
                                              'Pay Now',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF9747FF),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 16),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DateTime _parseTime(String time) {
    try {
      final parts = time.split(':');
      final now = DateTime.now();
      return DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    } catch (e) {
      return DateTime.now();
    }
  }
}

// Custom painter for the exact bubble button design
class BubbleButtonPainter extends CustomPainter {
  final Color color;

  BubbleButtonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Starting from top-left
    path.moveTo(20, 0);

    // Top line to right
    path.lineTo(size.width - 20, 0);

    // Top right corner
    path.quadraticBezierTo(size.width, 0, size.width, 20);

    // Right side
    path.lineTo(size.width, size.height - 20);

    // Bottom right corner
    path.quadraticBezierTo(
        size.width, size.height, size.width - 20, size.height);

    // Bottom line
    path.lineTo(40, size.height);

    // Bottom left tail (more pronounced, matching image)
    path.quadraticBezierTo(30, size.height, 0, size.height + 20);
    path.quadraticBezierTo(15, size.height - 5, 20, size.height - 10);

    // Left side
    path.lineTo(20, 20);

    // Top left corner
    path.quadraticBezierTo(20, 0, 20, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom border for the InkWell effect matching the exact shape
class BubbleButtonBorder extends ShapeBorder {
  const BubbleButtonBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();

    path.moveTo(rect.left + 20, rect.top);
    path.lineTo(rect.right - 20, rect.top);
    path.quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + 20);
    path.lineTo(rect.right, rect.bottom - 20);
    path.quadraticBezierTo(
        rect.right, rect.bottom, rect.right - 20, rect.bottom);
    path.lineTo(rect.left + 40, rect.bottom);
    path.quadraticBezierTo(
        rect.left + 30, rect.bottom, rect.left, rect.bottom + 20);
    path.quadraticBezierTo(
        rect.left + 15, rect.bottom - 5, rect.left + 20, rect.bottom - 10);
    path.lineTo(rect.left + 20, rect.top + 20);
    path.quadraticBezierTo(rect.left + 20, rect.top, rect.left + 20, rect.top);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
