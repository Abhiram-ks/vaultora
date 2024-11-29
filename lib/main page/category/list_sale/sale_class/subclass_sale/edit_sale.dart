
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final String labelText;
  final String valueText;

  const InfoRow({
    super.key,
    required this.iconData,
    required this.iconColor,
    required this.labelText,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Icon(
            iconData,
            color: iconColor,
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                labelText,
                style: const TextStyle(
                  color: Color.fromARGB(255, 9, 84, 12),
                  fontSize: 12,
                ),
              ),
              Text(
                valueText,
                style: const TextStyle(
                  color: Color.fromARGB(255, 132, 132, 132),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
