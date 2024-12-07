import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import '../../common/appbar.dart';
import '../screen_tapbar/annualy.dart';
import '../screen_tapbar/custom_revanue.dart';
import '../screen_tapbar/per_month.dart';
import '../screen_tapbar/day_wise.dart';

class MonitoringRevenue extends StatefulWidget {
  const MonitoringRevenue({super.key});

  @override
  State<MonitoringRevenue> createState() => _MonitoringRevenueState();
}

class _MonitoringRevenueState extends State<MonitoringRevenue> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_updateAppBarColor);
  }

  void _updateAppBarColor() {
    if (!_tabController.indexIsChanging) return;

    setState(() {
      
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_updateAppBarColor);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBarTwo(titleText: 'Sales Overview',bgColor: inside,),
      backgroundColor:  const Color.fromARGB(255, 29, 66, 77),
      body: Container(
        decoration: BoxDecoration(
          color:  const Color.fromARGB(255, 29, 66, 77),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TabContainer(
          controller: _tabController,
          tabEdge: TabEdge.top,
          colors: [ whiteColor, whiteColor, whiteColor, whiteColor,
          ],
          selectedTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
          unselectedTextStyle:  TextStyle(
            color: whiteColor,
            fontSize: 13.0,
          ),
          tabs: const [
            Text('Today'),
            Text('Monthly'),
            Text('Annually'),
            Text('Tracker'),
          ],
          childDuration: const Duration(milliseconds: 300),
          childCurve: const ElasticInCurve(10),
          children:const [
           DayWise(),
           PerMonth(),
           Annualy(),
           Customisation(),
          ],
        ),
      ),
    );
  }
}


