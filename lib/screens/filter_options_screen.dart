import 'package:find_jobs/objects/jobs.dart';
import 'package:find_jobs/providers/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum JobType {
  FullTime,
  Contract,
  PartTime,
}


class FilterOptionsScreen extends StatefulWidget {
  @override
  _FilterOptionsScreenState createState() => _FilterOptionsScreenState();
}

class _FilterOptionsScreenState extends State<FilterOptionsScreen> {
  JobType _filterType = JobType.FullTime;
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
              title: const Text('Full Time'),
              value: JobType.FullTime,
              groupValue: _filterType,
              onChanged: (value) {
                setState(() {
                  _filterType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Part Time'),
              value: JobType.PartTime,
              groupValue: _filterType,
              onChanged: (value) {
                setState(() {
                  _filterType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Contract'),
              value: JobType.Contract,
              groupValue: _filterType,
              onChanged: (value) {
                setState(() {
                  _filterType = value;
                });
              },
            ),
            Container(
              width: double.infinity,
              child: FlatButton(
                  onPressed: () {
                    Job.flag=true;
                    print('in filter_options_screen');
                    Provider.of<FetchData>(context, listen: false).filter(1,jobType: _filterType);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'FILTER',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
