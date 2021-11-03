import 'package:flutter/material.dart';

import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  RangeValues _values = RangeValues(10, 100000);

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
    var v = Provider.of<FilterProvider>(context, listen: false).range;
    _values = RangeValues(v[0].toDouble(), v[1].toDouble());
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Filter by Price Range',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 20),
                      child: SliderTheme(
                        data: SliderThemeData(
                          activeTickMarkColor: Colors.transparent,
                          inactiveTickMarkColor: Colors.transparent,
                          activeTrackColor: Colors.amberAccent[100],
                          inactiveTrackColor: Colors.black12,
                          thumbColor: Colors.teal,
                          overlayColor: Colors.tealAccent[100],
                        ),
                        child: RangeSlider(
                          min: 1,
                          max: 1000000,
                          divisions: 100000,
                          labels: RangeLabels(
                            _values.start.round().toString(),
                            _values.end.round().toString(),
                          ),
                          values: _values,
                          onChanged: (v) {
                            setState(() {
                              _values = v;
                            });
                          },
                          onChangeEnd: (value) {
                            Provider.of<FilterProvider>(context, listen: false)
                                .editRange(value.start, value.end);
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Min',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 120.0,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: const Color(0xff092E34),
                                    width: 2.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.rupeeSign,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _values.start.round().toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Max',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 120.0,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: const Color(0xff092E34),
                                    width: 2.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.rupeeSign,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _values.end.round().toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
