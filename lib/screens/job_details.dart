import 'package:find_jobs/objects/jobs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:find_jobs/providers/fetch_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

class JobDetails extends StatelessWidget {
  int id;
  static const routeName = '/jobDetails';

  @override
  Widget build(BuildContext context) {
    id=ModalRoute.of(context).settings.arguments as int;
    final data = Provider.of<FetchData>(context,listen: false);
    Job detail= data.getItem(id);
    String employmentType =detail.job_type=='full_time'?'Full Time':detail.job_type=='contract'?'Contract':detail.job_type=='part_time'?'Part Time':detail.job_type;

    return Scaffold(
      appBar: AppBar(title: Text(detail.company_name),),
      body: SizedBox.expand(
        child: Container(
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              elevation: 10,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(detail.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Text('Published on : '+detail.publication_date.toString().split(' ')[0],style: TextStyle(color: Colors.green),),
                Padding(
                  padding: const EdgeInsets.only(bottom:5.0),
                  child: Text('Category : '+detail.category,style: TextStyle(color: Colors.grey),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:5.0),
                  child: Text('Employment Type : '+employmentType),
                ),
                Text('Candidate Required Location : '+detail.candidate_required_location),
                Text('Salary : '+detail.salary==''?'Unavailable':detail.salary),
                Text('Visit Website :'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: _launchURLApp,
                    child: Text(detail.url),
                  ),
                ),
                Html(padding: EdgeInsets.all(12.0),data:detail.description),
                Text('Visit Website :'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: _launchURLApp,
                    child: Text(detail.url),
                  ),
                ),
              ],),
            ),
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

