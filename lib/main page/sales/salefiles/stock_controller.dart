import 'package:flutter/material.dart';

class StockRow extends StatelessWidget {
  final String? mrp;
  final String? stock;
  final Function() onIncrease;
  final Function() onDecrease;
  final int stockCount;

  const StockRow({
    super.key,
    this.mrp,
    this.stock,
    required this.onIncrease,
    required this.onDecrease,
    required this.stockCount,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.price_change,
                          size: 16, color: Colors.black),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'MRP: ${mrp ?? 'N/A'}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.inventory,
                          size: 16, color: Colors.black),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Stock: ${stock ?? 'N/A'}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: onDecrease,
                  iconSize: 24.0,
                  padding: const EdgeInsets.all(8),
                  splashColor: Colors.grey,
                  highlightColor: Colors.grey,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      stockCount.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: onIncrease,
                  iconSize: 24.0,
                  padding: const EdgeInsets.all(8),
                  splashColor: Colors.green,
                  highlightColor: Colors.green,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
