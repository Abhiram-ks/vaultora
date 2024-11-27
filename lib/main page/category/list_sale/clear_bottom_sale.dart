
import 'package:flutter/material.dart';

class ClearFilterBottomSaleSheet extends StatelessWidget {
  final VoidCallback onClear;

  const ClearFilterBottomSaleSheet({
    super.key,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
              const SizedBox(height: 10),
          const Padding(
             padding:  EdgeInsets.only(left: 20.0),
             child: Align(
              alignment: Alignment.bottomLeft,
               child:  Text(
                    "Clear Filters",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
             ),
           ),
          const SizedBox(height: 10),
          const Text(
            "Would you like to clear the following filters?",
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 129, 129, 129)),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromRGBO(158, 158, 158, 1), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                   onPressed: onClear,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Clear"),
                ),
              ),
                 const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
