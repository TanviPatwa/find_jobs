import 'dart:convert';
import 'package:find_jobs/objects/jobs.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class FetchData with ChangeNotifier {
  List<Job> _items = [];
  List<String> _uniqueTitles=[];
  String _Jtitle ='';

  List<Job> get items {
    return [..._items];
  }

  List<String> get uniqueTitles{
    return [..._uniqueTitles];
  }

  Job getItem(int id){
    return _items.firstWhere((element) => element.id == id);
  }

  List<Job> getItemByTitle(String title){
    _Jtitle = title;
    return _items.where((e) => e.title.toLowerCase()==title.toLowerCase()).toList();
  }

  String get Jtitle{
    return _Jtitle;
  }

  Future<void> fetchingData() async {
    try {
      if (_items.length > 0) {
        _items.clear();
      }
      print('in fetch_data'+Jtitle);
      List<String> jobTitles=[];
      final url = "https://remotive.io/api/remote-jobs";
      final response1 = await http.get(Uri.parse(url));
      List allJobs = json.decode(response1.body)['jobs'];
      List<Job> jobList = [];
      for (var i = 0; i < allJobs.length; i++) {
        Map job = allJobs[i];
        Job singleJob = Job(
          id: job['id'],
          url: job['url'],
          title: job['title'],
          company_name: job['company_name'],
          category: job['category'],
          tags: job['tags'],
          job_type: job['job_type'],
          publication_date: job['publication_date'],
          candidate_required_location: job['candidate_required_location'],
          salary: job['salary'],
          description: job['description'],
        );
        jobList.add(singleJob);
        jobTitles.add(job['title']);
      }
      _items.addAll(jobList);
      if(jobTitles!=null)
        _uniqueTitles =jobTitles.toSet().toList();
      // print(_uniqueTitles);
      // print(_uniqueTitles.length);
      print(_items.length);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
