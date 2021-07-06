import 'package:flutter/cupertino.dart';

class Job {
  final int id;
  final String url;
  final String title;
  final String company_name;
  final String category;
  final List tags;
  final String job_type;
  final String publication_date;
  final String candidate_required_location;
  final String salary;
  final String description;

  Job(
      {@required this.id,
      this.url,
      @required this.title,
      @required this.company_name,
      this.category,
      this.tags,
      this.job_type,
      this.publication_date,
      this.candidate_required_location,
      this.salary,
      this.description});
}
