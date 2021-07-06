import 'dart:convert';
import 'package:find_jobs/objects/jobs.dart';
import 'package:find_jobs/screens/filter_options_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:find_jobs/screens/bottom_sort_screen.dart' show FilterType;
import 'package:find_jobs/screens/filter_options_screen.dart' show JobType;


class FetchData with ChangeNotifier {
  List<Job> _items = [];
  List<String> _uniqueTitles=[];
  List<String> _category=['All'];
  List<Job> _dummy=[];
  String _Jtitle ='';
  int flag=0;

  void filter(int whatChanged,{FilterType filtertype=FilterType.Ascending,JobType jobType=JobType.FullTime}) {
    _dummy=_items;
    if(Job.flag) {
      if(whatChanged==0) {
        if (filtertype == FilterType.Ascending) {
          _dummy
              .sort((a, b) => a.publication_date.compareTo(b.publication_date));
        } else if (filtertype == FilterType.Descending) {
          _dummy
              .sort((b, a) => a.publication_date.compareTo(b.publication_date));
        }
      }
      else if(whatChanged==1) {
        if (jobType == JobType.FullTime) {
          _dummy = _dummy.where((element) => (element.job_type == 'full_time')).toList();
        } else if (jobType == JobType.PartTime) {
          _dummy = _dummy.where((element) => (element.job_type == 'part_time')).toList();
        } else if (jobType == JobType.Contract) {
          _dummy = _dummy.where((element) => (element.job_type == 'contract')).toList();
        }
      }
      print('in provider');
      print(_dummy[0].job_type);
      notifyListeners();
    }
    else
      _dummy=_items;
  }
  //
  // void filter(JobType filterType,String categoryType, int date){
  //   if(flag==0)
  //     _dummy=_items;
  //   else
  //   _dummy = _items.where((element) => (element.job_type_filter == filterType)and(element.category)).toList();
  // }

  List<Job> get items {
    return [..._items];
  }

  List<Job> get dummys{
    return [..._dummy];
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
      // print('in fetch_data'+Jtitle);
      List<String> jobTitles=[];
      List<String> cat=[];
      final url = "https://remotive.io/api/remote-jobs";
      final response1 = await http.get(Uri.parse(url));
      List allJobs = json.decode(response1.body)['jobs'];
      List<Job> jobList = [];
      for (var i = 0; i < allJobs.length; i++) {
        Map job = allJobs[i];
        DateTime expiryAsDateTime = DateTime.parse(job['publication_date']);
        Job singleJob = Job(
          id: job['id'],
          url: job['url'],
          title: job['title'],
          company_name: job['company_name'],
          category: job['category'],
          tags: job['tags'],
          job_type: job['job_type'],
          publication_date: expiryAsDateTime,
          candidate_required_location: job['candidate_required_location'],
          salary: job['salary'],
          description: job['description'],
        );
        jobList.add(singleJob);
        jobTitles.add(job['title']);
        cat.add(job['category']);
      }
      _items.addAll(jobList);
      _dummy=_items;
      if(jobTitles!=null) {
        _uniqueTitles = jobTitles.toSet().toList();
        _category.addAll(cat.toSet().toList());

      }
      print(_items.length);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
