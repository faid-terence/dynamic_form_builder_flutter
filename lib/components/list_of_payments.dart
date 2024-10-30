import 'package:flutter/material.dart';

class ListOfPayments extends StatelessWidget {
  final String number;
  final String phoneNumber;
  final Function()? onPressed;
  const ListOfPayments({
    super.key,
    required this.number,
    required this.phoneNumber,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // number
          Text.rich(
            TextSpan(
              text: number,
              style: TextStyle(fontWeight: FontWeight.bold),
              children: const [
                // space
                TextSpan(
                  text: ' ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: '0780 000 000',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),

          Row(
            children: [
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Color(0xFF8413F5),
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'Edit',
                style: TextStyle(
                  color: Color(0xFF8413F5),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
