import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onAddSalePressed;
  final VoidCallback onCheckoutPressed;
  final String addSaleText;
  final String checkoutText;

  const ActionButtons({
    super.key,
    required this.onAddSalePressed,
    required this.onCheckoutPressed,
    required this.addSaleText,
    required this.checkoutText,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.058,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: TextButton(
                onPressed: onAddSalePressed,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.black),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  addSaleText,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: TextButton(
                onPressed: onCheckoutPressed,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  checkoutText,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
