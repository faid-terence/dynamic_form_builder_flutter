import 'package:flutter/material.dart';

class NeuBoxComponent extends StatelessWidget {
  final Widget? child;
  const NeuBoxComponent({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(4, 4),
              blurRadius: 15,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 15,
            ),
          ]),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
