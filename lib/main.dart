import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'choser.dart';
import 'provider/task_provider.dart';
import 'provider/table_provider.dart';
import 'provider/item_request_provider.dart';
import 'splash_screen.dart';
import 'provider/repair_details_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'provider/job_request_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JobRequestProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) {
          final tableDataProvider = TableDataProvider();
          tableDataProvider.loadTableData();
          return tableDataProvider;
        }),
        ChangeNotifierProvider(create: (context) => ItemRequestProvider()),
        ChangeNotifierProvider(create: (_) => RepairDetailsProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: SplashScreen(),
        routes: {
          '/choser': (context) => Choser(),
        },
      ),
    );
  }
}