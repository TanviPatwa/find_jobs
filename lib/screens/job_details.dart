import 'package:find_jobs/objects/jobs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:find_jobs/providers/fetch_data.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetails extends StatelessWidget {
  int id;
  static const routeName = '/jobDetails';

  @override
  Widget build(BuildContext context) {
    id=ModalRoute.of(context).settings.arguments as int;
    final data = Provider.of<FetchData>(context,listen: false);
    Job detail= data.getItem(id);
    return Scaffold(
      appBar: AppBar(title: Text(detail.company_name),),
      body: SizedBox.expand(
        child: Container(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            elevation: 10,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(detail.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              // Text(detail.description),
              TextButton(
                onPressed: _launchURLApp,
                child: Text(detail.url),
              ),
            ],),
          ),
        ),
      ),
    );
  }
}
_launchURLApp() async {
  const url = 'https://www.geeksforgeeks.org/';
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

