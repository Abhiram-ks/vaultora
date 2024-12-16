import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'splash_and_welcome/splash_screen.dart';
import 'db/helpers/addfunction.dart';
import 'db/helpers/adminfunction.dart';
import 'db/helpers/categoryfunction.dart';
import 'db/helpers/salefuction.dart';
import 'db/models/category/catalog.dart';
import 'db/models/product/add.dart';
import 'db/models/sales/onsale.dart';
import 'db/models/user/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); 
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(AddModelAdapter());
  Hive.registerAdapter(SalesModelAdapter());
  Hive.registerAdapter(SaleProductAdapter());
  await initUserDB();
  await initCategoryDB();
  await initAddDB();
  await initSalesDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaultora',
      theme: ThemeData(
        useMaterial3: true,
       primarySwatch: Colors.blue,
       brightness: Brightness.light,
       scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}
