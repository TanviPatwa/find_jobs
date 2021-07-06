import 'package:find_jobs/providers/fetch_data.dart';
import 'package:find_jobs/widgets/jobs_list.dart';
import 'package:find_jobs/widgets/list_look.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

List<String> titlesL;
class ListedJobsScreen extends StatefulWidget {
  @override
  _ListedJobsScreenState createState() => _ListedJobsScreenState();
}

class _ListedJobsScreenState extends State<ListedJobsScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<FetchData>(context).fetchingData().then((_) {
        titlesL = Provider.of<FetchData>(context,listen: false).uniqueTitles.toList();
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  String title='';

  @override
  Widget build(BuildContext context) {
    // titlesL = Provider.of(context)<FetchData>(context).uniqueTitles;
    print('in listed_jobs_screen'+title);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Find your Job!')),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              }),
        ],
      ),
      body: _isLoading?Center(
        child: CircularProgressIndicator(),
      ):ListLook(title)
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  String selectedTitle='';
  final titles = titlesL;
  // final titles = [
  //   'Growth Marketing Manager',
  //   'Fullstack Software Engineer',
  //   'Senior Data Engineer',
  //   'Drupal Developer',
  //   'Director of Culinary',
  //   'Medical Writing Quality ControlSpecialist',
  //   'HR Generalist',
  //   'Contracts and Compliance Attorney',
  //   'Finance Controller',
  //   'DevOps (Azure/GCP/AWS)',
  //   'Cloud Computing with AWS Course',
  //   'Data Entry Representative',
  //   'Senior Data Scientist',
  //   'Senior Director of Product',
  //   'Payments',
  //   'Product Manager',
  //   'Product Manager (m/f/d)',
  //   'Sales Development Representative',
  //   'Alliance Manager III',
  //   'Content Manager',
  //   'Product Adoption Manager',
  //   'Communications and CRM Manager',
  //   'Level, Mission Game Designer',
  //   'Creative Director',
  //   'Brand Lab',
  //   'Compliance Support Associate',
  //   'Client Support Representative',
  //   'Staff Software Engineer',
  //   'Buying Confidence',
  //   'Senior developer',
  //   ' VP Client Deployment',
  //   'NA',
  //   'Education Editor',
  //   'Quality Assurance Manager',
  //   'Human Resources Manager',
  //   'Recruiter',
  //   'Senior Accountant',
  //   'FP&A Manager',
  //   'SAP Trainer',
  //   'Junior SAP Recruiter',
  //   'Data Scientist',
  //   'INVESTIGATIVE ANALYST LEVEL 2',
  //   'INVESTIGATIVE ANALYST LEVEL 1',
  //   'Head of Product - Marketplace'
  // ];
  final recent = [
    'Fullstack Software Engineer',
    'Senior Data Engineer',
    'Drupal Developer'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          selectedTitle='';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_outlined),
        onPressed: () {
          close(context, null);
        });
  }



  @override
  Widget buildResults(BuildContext context) {
    // close(context, null);
    if(query.isEmpty)
      query='';
    selectedTitle = query.length>selectedTitle.length?query:selectedTitle;
    print(selectedTitle);
    return ListLook(selectedTitle);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recent
        : titles
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          selectedTitle=suggestionList[index].substring(query.length);
          showResults(context);
        },
        leading: Icon(Icons.computer_outlined),
        // title: Text(suggestionList[index]),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
