
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalesCard extends StatefulWidget {
  final String data;
  final String name;
  final String address;
  final String phone;
  final String total;
  final String ifcCode;
  final String time;
  final VoidCallback onTap;

  const SalesCard({
    super.key,
    required this.data,
    required this.name,
    required this.address,
    required this.phone,
    required this.total,
    required this.ifcCode,
    required this.time,
    required this.onTap,
  });

  @override
  State<SalesCard> createState() => _SalesCardState();
}

class _SalesCardState extends State<SalesCard> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          height: screenHeight * 0.166,
          width: double.infinity,
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: screenHeight * 03,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFE8EDEB),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: screenWidth * 0.35,
                                  height: screenHeight * 0.04,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.calendar_month,color:Colors.black),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Text(widget.data),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    const Icon(Icons.person,color:Colors.grey),
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.4,
                                      child: Text(
                                        widget.name,
                                        style: GoogleFonts.anybody(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (showDetails) ...[
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.03,
                                      ),
                                      const Icon(Icons.location_on,color:Colors.blue),
                                      SizedBox(
                                        width: screenWidth * 0.03,
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.4,
                                        child: Text(
                                          widget.address,
                                          style: GoogleFonts.kodchasan(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.03,
                                      ),
                                      const Icon(Icons.phone,
                                          color: Colors.green),
                                      SizedBox(
                                        width: screenWidth * 0.03,
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.4,
                                        child: Text(
                                          widget.phone,
                                          style: GoogleFonts.kodchasan(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showDetails = !showDetails;
                                  });
                                },
                                child: Text(
                                  showDetails ? 'Hide Details' : 'Show Details',
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '₹ ${widget.total}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: screenHeight*0.04,
                          ),
                          Row(
                            children: [
                          const Icon(
                            Icons.timer_outlined,color: Colors.amber,
                          ),SizedBox(width: screenWidth*0.02,),
                          Text(
                            widget.time,
                            style: const TextStyle(color: Colors.grey),
                          ),
                            ]
                         
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 140, 255),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.ifcCode,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
