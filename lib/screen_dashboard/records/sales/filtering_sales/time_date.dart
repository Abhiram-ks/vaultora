import 'package:flutter/material.dart';

class CustomSnackBarTime {
  static void show(BuildContext context, String message1, String message2) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(message1,style: const TextStyle(color: Colors.black),),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.timer_sharp,
              color: Colors.black,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(message2,style: const TextStyle(color: Colors.black)),
          ],
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.black,
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.grey, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}


class DateTimeDisplay extends StatelessWidget {
  final String formattedDate;
  final String formattedTime;

  const DateTimeDisplay({
    super.key,
    required this.formattedDate,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(formattedDate),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(formattedTime,style: const TextStyle(color: Colors.grey),),
            ),
          ],
        ),
      ),
    );
  }
}
