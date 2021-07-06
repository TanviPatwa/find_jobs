import 'package:find_jobs/providers/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:find_jobs/objects/jobs.dart';
import 'jobs_list.dart';

class ListLook extends StatelessWidget {
  String title;
  ListLook(this.title);
  @override
  Widget build(BuildContext context) {
    List<Job> data=[];
    final providerObject = Provider.of<FetchData>(context);
    if(Job.flag && title=='') {
      Job.flag=false;
      data = providerObject.dummys;
    } else if(title==''){
      data = providerObject.items;
      print(data.length);
    }
    else
      data = providerObject.getItemByTitle(title);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          data.length==0?Center(child: Text('No Results Found!',style: TextStyle(fontSize: 20,color: Colors.grey),)):Consumer<FetchData>(
            builder: (context, job, child) => Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context,i) => JobsList(data[i].id),
                )),
          ),
        ],
      ),
    );
  }
}
