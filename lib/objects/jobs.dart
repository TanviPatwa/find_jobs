import 'package:flutter/cupertino.dart';

class Job {
  final int id;
  final String url;
  final String title;
  final String company_name;
  final String category;
  final List tags;
  final String job_type;
  final DateTime publication_date;
  final String candidate_required_location;
  final String salary;
  final String description;
  static bool flag = false;

  Job({
    @required this.id,
    this.url,
    @required this.title,
    @required this.company_name,
    @required this.category,
    this.tags,
    @required this.job_type,
    @required this.publication_date,
    this.candidate_required_location,
    this.salary,
    this.description,
  });
}
