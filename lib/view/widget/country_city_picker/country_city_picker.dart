import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';
import './model/city_model.dart';
import './model/country_model.dart';
import './model/state_model.dart';

// ignore: must_be_immutable
class CountryStateCityPicker extends StatefulWidget {
  final TextEditingController country;
  final TextEditingController state;
  final TextEditingController city;
  final InputDecoration? textFieldDecoration;
  final Color? dialogColor;

  const CountryStateCityPicker(
      {super.key,
      required this.country,
      required this.state,
      this.textFieldDecoration,
      this.dialogColor,
      required this.city});

  @override
  State<CountryStateCityPicker> createState() => _CountryStateCityPickerState();
}

class _CountryStateCityPickerState extends State<CountryStateCityPicker> {
  List<CountryModel> _countryList = [];
  final List<StateModel> _stateList = [];
  final List<CityModel> _cityList = [];

  List<CountryModel> _countrySubList = [];
  List<StateModel> _stateSubList = [];
  List<CityModel> _citySubList = [];
  String _title = '';

  @override
  void initState() {
    _getCountry();
    super.initState();
  }

  Future<void> _getCountry() async {
    _countryList.clear();
    var jsonString =
        await rootBundle.loadString('assets/country_city_json/country.json');
    List<dynamic> body = json.decode(jsonString);
    setState(() {
      _countryList =
          body.map((dynamic item) => CountryModel.fromJson(item)).toList();
      _countrySubList = _countryList;
    });
  }

  Future<void> _getState(String countryId) async {
    _stateList.clear();
    _cityList.clear();
    List<StateModel> subStateList = [];
    var jsonString =
        await rootBundle.loadString('assets/country_city_json/state.json');
    List<dynamic> body = json.decode(jsonString);

    subStateList =
        body.map((dynamic item) => StateModel.fromJson(item)).toList();
    for (var element in subStateList) {
      if (element.countryId == countryId) {
        setState(() {
          _stateList.add(element);
        });
      }
    }
    _stateSubList = _stateList;
  }

  Future<void> _getCity(String stateId) async {
    _cityList.clear();
    List<CityModel> subCityList = [];
    var jsonString =
        await rootBundle.loadString('assets/country_city_json/city.json');
    List<dynamic> body = json.decode(jsonString);

    subCityList = body.map((dynamic item) => CityModel.fromJson(item)).toList();
    for (var element in subCityList) {
      if (element.stateId == stateId) {
        setState(() {
          _cityList.add(element);
        });
      }
    }
    _citySubList = _cityList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Country TextField
        //
        const CustomText(
          top: 20,
          bottom: 8,
          text: AppStaticStrings.country,
        ),
        CustomTextField(
          validator: (value) {
            if (value == null || value.toString().isEmpty) {
              return AppStaticStrings.fieldCantBeEmpty;
            }
            return null;
          },
          onTapClick: () {
            setState(() => _title = 'Country');
            _showDialog(context);
          },
          hintText: AppStaticStrings.country,
          textEditingController: widget.country,
        ),

        const SizedBox(height: 8.0),

        //State TextField
        const CustomText(
          top: 20,
          bottom: 8,
          text: AppStaticStrings.state,
        ),
        CustomTextField(
          validator: (value) {
            if (value == null || value.toString().isEmpty) {
              return AppStaticStrings.fieldCantBeEmpty;
            }
            return null;
          },
          onTapClick: () {
            setState(() => _title = 'State');
            _showDialog(context);
          },
          hintText: AppStaticStrings.state,
          textEditingController: widget.state,
        ),

        ///City TextField
        ///
        const CustomText(
          top: 20,
          bottom: 8,
          text: AppStaticStrings.city,
        ),

        CustomTextField(
          validator: (value) {
            if (value == null || value.toString().isEmpty) {
              return AppStaticStrings.fieldCantBeEmpty;
            }
            return null;
          },
          onTapClick: () {
            setState(() => _title = 'City');
            if (widget.country.text.isNotEmpty) {
              _showDialog(context);
            } else {
              _showSnackBar('Select Country');
            }
          },
          hintText: AppStaticStrings.city,
          textEditingController: widget.city,
        ),

        const SizedBox(height: 8.0),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    final TextEditingController controller3 = TextEditingController();

    showGeneralDialog(
      barrierLabel: _title,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, animation, ___) {
        const Offset begin = Offset(0.0, 1.0);
        const Offset end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: Material(
            animationDuration: const Duration(milliseconds: 100),
            color: Colors.transparent,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .7,
                    margin: const EdgeInsets.only(top: 60, left: 12, right: 12),
                    decoration: BoxDecoration(
                      color: widget.dialogColor ?? Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(_title,
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 17,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),

                        ///Text Field
                        TextField(
                          controller: _title == 'Country'
                              ? controller
                              : _title == 'State'
                                  ? controller2
                                  : controller3,
                          onChanged: (val) {
                            setState(() {
                              if (_title == 'Country') {
                                _countrySubList = _countryList
                                    .where((element) => element.name
                                        .toLowerCase()
                                        .contains(
                                            controller.text.toLowerCase()))
                                    .toList();
                              } else if (_title == 'State') {
                                _stateSubList = _stateList
                                    .where((element) => element.name
                                        .toLowerCase()
                                        .contains(
                                            controller2.text.toLowerCase()))
                                    .toList();
                              } else if (_title == 'City') {
                                _citySubList = _cityList
                                    .where((element) => element.name
                                        .toLowerCase()
                                        .contains(
                                            controller3.text.toLowerCase()))
                                    .toList();
                              }
                            });
                          },
                          style: TextStyle(
                              color: Colors.grey.shade800, fontSize: 16.0),
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Search here...",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              isDense: true,
                              prefixIcon: Icon(Icons.search)),
                        ),

                        ///Dropdown Items
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            itemCount: _title == 'Country'
                                ? _countrySubList.length
                                : _title == 'State'
                                    ? _stateSubList.length
                                    : _citySubList.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  setState(() {
                                    if (_title == "Country") {
                                      widget.country.text =
                                          _countrySubList[index].name;
                                      _getState(_countrySubList[index].id);
                                      _countrySubList = _countryList;
                                      widget.state.clear();
                                      widget.city.clear();
                                    } else if (_title == 'State') {
                                      widget.state.text =
                                          _stateSubList[index].name;
                                      _getCity(_stateSubList[index].id);
                                      _stateSubList = _stateList;
                                      widget.city.clear();
                                    } else if (_title == 'City') {
                                      widget.city.text =
                                          _citySubList[index].name;
                                      _citySubList = _cityList;
                                    }
                                  });
                                  controller.clear();
                                  controller2.clear();
                                  controller3.clear();
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20.0, left: 10.0, right: 10.0),
                                  child: Text(
                                      _title == 'Country'
                                          ? _countrySubList[index].name
                                          : _title == 'State'
                                              ? _stateSubList[index].name
                                              : _citySubList[index].name,
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 16.0)),
                                ),
                              );
                            },
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                          onPressed: () {
                            if (_title == 'City' && _citySubList.isEmpty) {
                              widget.city.text = controller3.text;
                            }
                            _countrySubList = _countryList;
                            _stateSubList = _stateList;
                            _citySubList = _cityList;

                            controller.clear();
                            controller2.clear();
                            controller3.clear();
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

  void _showSnackBar(String message) {
    Get.snackbar("Country?", message,
        duration: const Duration(seconds: 1),
        colorText: AppColors.white100,
        backgroundColor: AppColors.pink100);
  }
}
