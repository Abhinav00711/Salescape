import 'package:flutter/material.dart';

import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    Key? key,
    required this.isIndustry,
  }) : super(key: key);

  final bool isIndustry;

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> _myLocations = [];
  List<String> _myIndustries = [];

  List _industries = [
    {
      "display": "Agriculture",
      "value": "Agriculture",
    },
    {
      "display": "Healthcare and Pharmaceutical",
      "value": "Healthcare and Pharmaceutical",
    },
    {
      "display": "Infrastructure",
      "value": "Infrastructure",
    },
    {
      "display": "FMCG",
      "value": "FMCG",
    },
    {
      "display": "Fashion and Textiles",
      "value": "Fashion and Textiles",
    },
    {
      "display": "Automobile",
      "value": "Automobile",
    },
    {
      "display": "Chemical",
      "value": "Chemical",
    },
    {
      "display": "Electronics and Appliances",
      "value": "Electronics and Appliances",
    },
    {
      "display": "Furniture and Furnishing",
      "value": "Furniture and Furnishing",
    },
    {
      "display": "Sports and Fitness",
      "value": "Sports and Fitness",
    },
    {
      "display": "Household",
      "value": "Household",
    },
  ];
  List _states = [
    {
      "display": "Andhra Pradesh",
      "value": "Andhra Pradesh",
    },
    {
      "display": "Arunachal Pradesh",
      "value": "Arunachal Pradesh",
    },
    {
      "display": "Assam",
      "value": "Assam",
    },
    {
      "display": "Bihar",
      "value": "Bihar",
    },
    {
      "display": "Chhattisgarh",
      "value": "Chhattisgarh",
    },
    {
      "display": "Goa",
      "value": "Goa",
    },
    {
      "display": "Gujarat",
      "value": "Gujarat",
    },
    {
      "display": "Haryana",
      "value": "Haryana",
    },
    {
      "display": "Himachal Pradesh",
      "value": "Himachal Pradesh",
    },
    {
      "display": "Jammu and Kashmir",
      "value": "Jammu and Kashmir",
    },
    {
      "display": "Jharkhand",
      "value": "Jharkhand",
    },
    {
      "display": "Karnataka",
      "value": "Karnataka",
    },
    {
      "display": "Kerala",
      "value": "Kerala",
    },
    {
      "display": "Madhya Pradesh",
      "value": "Madhya Pradesh",
    },
    {
      "display": "Maharashtra",
      "value": "Maharashtra",
    },
    {
      "display": "Manipur",
      "value": "Manipur",
    },
    {
      "display": "Meghalaya",
      "value": "Meghalaya",
    },
    {
      "display": "Mizoram",
      "value": "Mizoram",
    },
    {
      "display": "Nagaland",
      "value": "Nagaland",
    },
    {
      "display": "Odisha",
      "value": "Odisha",
    },
    {
      "display": "Punjab",
      "value": "Punjab",
    },
    {
      "display": "Rajasthan",
      "value": "Rajasthan",
    },
    {
      "display": "Sikkim",
      "value": "Sikkim",
    },
    {
      "display": "Tamil Nadu",
      "value": "Tamil Nadu",
    },
    {
      "display": "Telangana",
      "value": "Telangana",
    },
    {
      "display": "Tripura",
      "value": "Tripura",
    },
    {
      "display": "Uttar Pradesh",
      "value": "Uttar Pradesh",
    },
    {
      "display": "Uttarakhand",
      "value": "Uttarakhand",
    },
    {
      "display": "West Bengal",
      "value": "West Bengal",
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _myLocations =
        Provider.of<FilterProvider>(context, listen: false).locations;
    _myIndustries =
        Provider.of<FilterProvider>(context, listen: false).industries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Filters',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiSelectFormField(
                autovalidate: false,
                fillColor: Colors.tealAccent,
                chipBackGroundColor: Colors.amber,
                chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: Colors.amber,
                checkBoxCheckColor: const Color(0xff092E34),
                dialogShapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                title: Text(
                  "Filter by Locations",
                  style: TextStyle(fontSize: 16),
                ),
                dataSource: _states,
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'CANCEL',
                hintWidget: Text('Select Locations...'),
                initialValue: _myLocations,
                onSaved: (value) {
                  if (value == null) return;
                  Provider.of<FilterProvider>(context, listen: false)
                      .editLocations(
                          (value as List).map((e) => e.toString()).toList());
                  setState(() {
                    _myLocations = (value).map((e) => e.toString()).toList();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiSelectFormField(
                autovalidate: false,
                enabled: !widget.isIndustry,
                fillColor:
                    widget.isIndustry ? Colors.grey[400] : Colors.tealAccent,
                chipBackGroundColor: Colors.amber,
                chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: Colors.amber,
                checkBoxCheckColor: const Color(0xff092E34),
                dialogShapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                title: Text(
                  "Filter by Industries",
                  style: TextStyle(fontSize: 16),
                ),
                dataSource: _industries,
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'CANCEL',
                hintWidget: Text('Select Industries...'),
                initialValue: _myIndustries,
                onSaved: (value) {
                  if (value == null) return;
                  Provider.of<FilterProvider>(context, listen: false)
                      .editIndustries(
                          (value as List).map((e) => e.toString()).toList());
                  setState(() {
                    _myIndustries = (value).map((e) => e.toString()).toList();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
