import 'package:flutter/material.dart';

class StepProgress extends StatefulWidget {
  final double currentStep;
  final double steps;
  const StepProgress(
      {super.key, required this.currentStep, required this.steps});

  @override
  State<StepProgress> createState() => _StepProgressState();
}

class _StepProgressState extends State<StepProgress> {
  double widthProgress = 0;

  @override
  void initState() {
    super.initState();
    _onSizeWidget();
  }

  void _onSizeWidget() {
    WidgetsBinding.instance.addPostFrameCallback((timeStap) {
      Size size = context.size!;
      widthProgress = size.width / widget.steps - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  '${(widget.currentStep + 1).toInt()}/${widget.steps.toInt()}'),
            ],
          ),
          Container(
            height: 4,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: Colors.purple,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    );
  }
}
