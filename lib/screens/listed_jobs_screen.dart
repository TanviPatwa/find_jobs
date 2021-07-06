import 'package:find_jobs/providers/fetch_data.dart';
import 'package:find_jobs/screens/filter_options_screen.dart';
import 'package:find_jobs/widgets/list_look.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_sort_screen.dart';

List<String> titlesL;

class ListedJobsScreen extends StatefulWidget {
  @override
  _ListedJobsScreenState createState() => _ListedJobsScreenState();
}

class _ListedJobsScreenState extends State<ListedJobsScreen> {
  var _isInit = true;
  var _isLoading = false;

  void sort(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return BottomFilterScreen();
        });
  }

  void filter(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return FilterOptionsScreen();
        });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<FetchData>(context).fetchingData().then((_) {
        titlesL = Provider.of<FetchData>(context, listen: false)
            .uniqueTitles
            .toList();
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Find your Job!')),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
            IconButton(
              icon: Icon(Icons.filter_list_alt),
              onPressed: () {
                filter(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {
                sort(context);
              },
            ),

          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListLook(title));
  }
}

class DataSearch extends SearchDelegate<String> {
  String selectedTitle = '';
  final titles = titlesL;

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
          selectedTitle = '';
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
    if (query.isEmpty) query = '';
    selectedTitle = query.length > selectedTitle.length ? query : selectedTitle;
    query = selectedTitle;
    // recent.insert(0, selectedTitle);
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
        onTap: () {
          selectedTitle = suggestionList[index];
          // print('this is selectedText ' + selectedTitle);
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
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
