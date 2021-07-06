import 'package:find_jobs/objects/jobs.dart';
import 'package:flutter/material.dart';
import 'package:find_jobs/providers/fetch_data.dart';
import 'package:provider/provider.dart';

enum FilterType {
  Ascending,
  Descending
}

class BottomFilterScreen extends StatefulWidget {

  @override
  _BottomFilterScreenState createState() => _BottomFilterScreenState();
}

class _BottomFilterScreenState extends State<BottomFilterScreen> {
  FilterType _filterType = FilterType.Ascending;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              'Filter by',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18),
            ),
            RadioListTile(
              title: const Text('Older Recruiting'),
              value: FilterType.Ascending,
              groupValue: _filterType,
              onChanged: (value) {
                setState(() {
                  _filterType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Latest Recruiting'),
              value: FilterType.Descending,
              groupValue: _filterType,
              onChanged: (value) {
                setState(() {
                  _filterType = value;
                });
              },
            ),

            Container(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    Job.flag=true;
                    Provider.of<FetchData>(context, listen: false).filter(0,filtertype: _filterType,);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'FILTER',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
