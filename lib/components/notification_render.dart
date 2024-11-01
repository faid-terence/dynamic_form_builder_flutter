import 'package:flutter/material.dart';

class NotificationRender extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final String emoji;
  final bool hasToPay;
  final String paymentLink;
  final VoidCallback? onInfoPressed;
  final VoidCallback? onPayPressed;

  const NotificationRender({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    this.emoji = "  d",
    this.hasToPay = true,
    this.paymentLink = "",
    this.onInfoPressed,
    this.onPayPressed,
  });

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            Navigator.pop(context);
          },
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
      body: Column(
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
          // Message bubble
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomRight: Radius.circular(hasToPay ? 0 : 12),
                      bottomLeft: const Radius.elliptical(0, 100),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: message,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                height: 1.47,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          time,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasToPay) ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPayPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE6DDF7),
                        foregroundColor: const Color(0xFF9747FF),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
