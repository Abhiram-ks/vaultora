import 'package:flutter/material.dart';

import '../../../../Color/colors.dart';

Widget multipleSalesSubfile(dynamic incrementCount, dynamic screenHeight, dynamic stockLevel, dynamic decrementCount, dynamic count){
  return      Card(
              color: whiteColor,
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Available Stock',
                                style: TextStyle(
                                  color: green,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              ValueListenableBuilder<int>(
                                valueListenable: stockLevel,
                                builder: (context, stock, child) {
                                  return Column(
                                    children: [
                                      Text(
                                        'Stock Level: ${stock.toInt()}',
                                        style:  TextStyle(
                                          color: black,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: decrementCount,
                          ),
                          Container(
                            color: Colors.grey[300],
                            width: 50,
                            child: Center(
                              child: Text(
                                '$count',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: incrementCount,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
}