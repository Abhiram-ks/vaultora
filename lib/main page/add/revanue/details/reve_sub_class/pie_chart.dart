import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

class PieChartWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final List<Color> segmentColors;
  final List<double> segmentValues;
  final List<String> segmentLabels;
  final List<String> sublabel;

  const PieChartWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.segmentColors,
    required this.segmentValues,
    required this.segmentLabels,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rowData = List.generate(
        segmentLabels.length,
        (index) => {
              "color": segmentColors[index % segmentColors.length],
              "label": segmentLabels[index],
              "sublsbel": sublabel[index]
            });

    return PinchToZoomScrollableWidget(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: screenWidth*0.97,
            height: screenHeight * 0.3,
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                child: Container(
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 29, 66, 77).withOpacity(0.1),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.08,
                            left: screenWidth * 0.01,
                          ),
                          child: Column(
                            children: rowData.map((data) {
                              return Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color: data["color"],
                                      width: screenHeight * 0.015,
                                      height: screenHeight * 0.015,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  SizedBox(
                                    width: screenWidth * 0.26,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["label"],
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          data["sublsbel"],
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: PieChart(
                          PieChartData(
                            sections:
                                List.generate(segmentValues.length, (index) {
                              return PieChartSectionData(
                                value: segmentValues[index],
                                color: segmentColors.isNotEmpty
                                    ? segmentColors[
                                        index % segmentColors.length]
                                    : Colors.blue,
                                showTitle: true,
                                title: '${segmentValues[index]}%',
                                titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                radius: 45 + (index * 7),
                                badgePositionPercentageOffset: 1.2,
                              );
                            }),
                            sectionsSpace: 1.8,
                            centerSpaceRadius: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
