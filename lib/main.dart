import 'package:find_jobs/providers/fetch_data.dart';
import 'package:find_jobs/screens/job_details.dart';
import 'package:find_jobs/screens/listed_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) => FetchData(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Find Jobs',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Lato',
        ),
        home: ListedJobsScreen(),
        routes: {
          JobDetails.routeName: (context) => JobDetails(),
        },
      ),
    );
  }
}
