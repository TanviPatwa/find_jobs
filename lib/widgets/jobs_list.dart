import 'package:find_jobs/objects/jobs.dart';
import 'package:find_jobs/providers/fetch_data.dart';
import 'package:find_jobs/screens/job_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobsList extends StatelessWidget {
  static const routeName = '/jobsList';
  int i;
  JobsList(this.i);
  @override
  Widget build(BuildContext context) {
    final providerObject = Provider.of<FetchData>(context,listen: false);
    List<Job> data;
    print('in jobs_list'+providerObject.Jtitle);
    if(providerObject.Jtitle==''){
      data = providerObject.items;
      print('all');
      print(data[i].title);
    }
    else
      data = providerObject.getItemByTitle(providerObject.Jtitle);
    return GestureDetector(
      onTap: (){Navigator.of(context)
          .pushNamed(JobDetails.routeName,arguments: data[i].id);
      },
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(

            // leading: CircleAvatar(
            //   child: Padding(
            //       padding: EdgeInsets.all(5),
            //       child: FittedBox(
            //         child: Text('image'),//add image of that
            //       )),
            // ),

            title: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(data[i].title,style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:5.0),
                  child: Text(data[i].company_name,style: TextStyle(color: Colors.black),),
                ),
                Text('Category: '+data[i].category),
              ],
            ),
            trailing: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data[i].publication_date.split('T')[0],style: TextStyle(color: Colors.green),),
                ),
                Text(data[i].job_type=='full_time'?'Full Time':data[i].job_type=='contract'?'Contract':data[i].job_type,style: TextStyle(color: Colors.grey),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
