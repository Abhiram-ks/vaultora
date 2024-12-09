import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/models/sales/onsale.dart';

class CalederMarker extends StatefulWidget {
  const CalederMarker({super.key});

  @override
  State<CalederMarker> createState() => _CalederMarkerState();
}

class _CalederMarkerState extends State<CalederMarker> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late Box<SalesModel> salesBox;

  @override
  void initState() {
    super.initState();
    initSalesDB();
  }

  Future<void> initSalesDB() async {
    if (!Hive.isBoxOpen('salesBox')) {
      salesBox = await Hive.openBox<SalesModel>('salesBox');
    } else {
      salesBox = Hive.box<SalesModel>('salesBox');
    }
    setState(() {});
  }

bool _isSaleDone(DateTime date) {
 String formattedInputDate = DateFormat('yyyy-MM-dd').format(date);
   String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (formattedInputDate.compareTo(todayDate) <= 0){
      for(var sale in salesBox.values){
          DateTime saleDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(sale.id));
           if (DateFormat('yyyy-MM-dd').format(saleDate) == formattedInputDate) {
          return true;
        }
      }
      return false;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.02,
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2500, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            backgroundBlendMode: BlendMode.multiply,
            shape: BoxShape.circle,
            color: black,
            border: Border.all(
              color: whiteColor,
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
                offset: Offset(2, 2),
              ),
            ],
            gradient: RadialGradient(
              colors: [whiteColor, black],
              center: Alignment.center,
              radius: 1.0,
            ),
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: inside,
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: transParent,
          ),
          outsideDaysVisible: false,
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
          String formattedInputDate = DateFormat('yyyy-MM-dd').format(date);
         String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

         if(formattedInputDate.compareTo(todayDate) <= 0){
          return Stack(
            children: [
              Positioned(
                bottom: 1,
                right: 1,
                child: Icon(
                  _isSaleDone(date)? Icons.check_circle: Icons.cancel,
                  color: _isSaleDone(date)? green:redColor,
                  size: 15,
                )
              
                )
            ],
          );
         }
          return null;
          },
        ),
      ),
    );
  }
}
