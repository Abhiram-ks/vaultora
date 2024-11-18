import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/appbar.dart';



class SalesData extends StatefulWidget {

  const SalesData({super.key,});

  @override
  State<SalesData> createState() => _SalesDataState();
}

class _SalesDataState extends State<SalesData> {
  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:const MyAppBarTwo(titleText: 'Sales Record'),
     body: SingleChildScrollView(
       
      ),
    );
  }
}