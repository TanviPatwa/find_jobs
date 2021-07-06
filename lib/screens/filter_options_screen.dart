import 'package:find_jobs/objects/jobs.dart';
import 'package:find_jobs/providers/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum JobType {
  FullTime,
  Contract,
  PartTime,
  All,
}

enum CategoryType {
  All,
  AllOthers,
  QA,
  FinanceLegal,
  DevOpsSysadmin,
  Data,
  Product,
  Sales,
  Marketing,
  Design,
  SoftwareDevelopment,
  HumanResources,
  CustomerService,
  Writing,
  Business,
  Teaching,
  MedicalHealth,
}

class FilterOptionsScreen extends StatefulWidget {
  @override
  _FilterOptionsScreenState createState() => _FilterOptionsScreenState();
}

class _FilterOptionsScreenState extends State<FilterOptionsScreen> {
  JobType _filterType = JobType.All;
  CategoryType _categoryType = CategoryType.All;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text('Click Filter button - provided at bottom',style: TextStyle(color: Colors.blue),),
            Text(
              'Filter by Job Type',
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
            RadioListTile(
              title: const Text('All'),
              value: JobType.All,
              groupValue: _filterType,
              onChanged: (value) {
                setState(() {
                  _filterType = value;
                });
              },
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Filter by Category',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18),
            ),
            RadioListTile(
              title: const Text('Medical Health'),
              value: CategoryType.MedicalHealth,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Teaching'),
              value: CategoryType.Teaching,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Business'),
              value: CategoryType.Business,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Writing'),
              value: CategoryType.Writing,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Customer Service'),
              value: CategoryType.CustomerService,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Human Resources'),
              value: CategoryType.HumanResources,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Software Development'),
              value: CategoryType.SoftwareDevelopment,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Design'),
              value: CategoryType.Design,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Marketing'),
              value: CategoryType.Marketing,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Sales'),
              value: CategoryType.Sales,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Product'),
              value: CategoryType.Product,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Data'),
              value: CategoryType.Data,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('DevOps / Sysadmin'),
              value: CategoryType.DevOpsSysadmin,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Finance / Legal'),
              value: CategoryType.FinanceLegal,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('QA'),
              value: CategoryType.QA,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('All others'),
              value: CategoryType.AllOthers,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('All'),
              value: CategoryType.All,
              groupValue: _categoryType,
              onChanged: (value) {
                setState(() {
                  _categoryType = value;
                });
              },
            ),
            Container(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    Job.flag = true;
                    Provider.of<FetchData>(context, listen: false)
                        .filter(1, jobType: _filterType,categoryType: _categoryType);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'FILTER',
                    style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: Colors.blue),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
