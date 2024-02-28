import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logisync/constants.dart';
import 'package:logisync/providers/providers.dart';
import 'package:logisync/screens/dashboard/components/stylizedButton.dart';
import 'package:logisync/screens/dashboard/components/vehicle_logs.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyMovementReportSearcher extends StatefulWidget {
  String title;
  String path;
  MyMovementReportSearcher({required this.title, required this.path});
  @override
  _MyMovementReportSearcherState createState() =>
      _MyMovementReportSearcherState();
}

class _MyMovementReportSearcherState extends State<MyMovementReportSearcher>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late List newData = [];
  late AnimationController _searchController;
  late Animation<Offset> _searchOffsetAnimation;
  DateTime selectedDate = DateTime.now();
  TextEditingController _fromDateController = TextEditingController();
  TextEditingController _toDateController = TextEditingController();
  TextEditingController _vehicleController = TextEditingController();
  String _vehicleImei = '';
  // String selectedImei = newData[index].imei;
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? selectedDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(), // Use the light theme for the date picker
          child: child!,
        );
      },
    );

    if (selectedDateTime != null) {
      TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (selectedTime != null) {
        // Combine date and time and update the text field
        selectedDate = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        String formattedDateTime =
            DateFormat('yyyy-MM-dd').format(selectedDate);

        // DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate);

        // Update the text field
        controller.text = formattedDateTime;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 1), // Adjust the duration as needed
      vsync: this,
    );
    _searchController = AnimationController(
      duration: Duration(seconds: 1), // Adjust the duration as needed
      vsync: this,
    );
    // Define the Tween for the offset
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, -1), // Offscreen top
      end: Offset(0, 0), // Onscreen center
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _searchOffsetAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Offscreen top
      end: Offset(0, 0), // Onscreen center
    ).animate(
      CurvedAnimation(
        parent: _searchController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation when the screen is initialized
    _controller.forward();
    _searchController.forward();
    _toDateController.text = DateTime.now().toLocal().toString().split(' ')[0];
    DateTime todayAtMidnight = DateTime.now().toLocal();
    todayAtMidnight = DateTime(todayAtMidnight.year, todayAtMidnight.month,
        todayAtMidnight.day, 0, 0, 0);
    _fromDateController.text =
        todayAtMidnight.toLocal().toString().split(' ')[0];
  }

  fetchData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    var themeModel = Provider.of<ThemeModel>(context, listen: false);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Slide Animation Example'),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  children: [
                    SlideTransition(
                      position: _searchOffsetAnimation,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width:
                              constraints.maxWidth * 0.25, // Adjust as needed
                          height: screenHeight * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: themeModel.mode == ThemeMode.light
                                ? secondaryColor
                                : lightSecondaryColor,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'Your Fleet (select any vehicle from the list)'),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Search'),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: ListView(
                                  children:
                                      List.generate(newData.length, (index) {
                                    return ListTile(
                                      leading: Icon(
                                        Icons.local_shipping,
                                        color: primaryColor,
                                      ),
                                      title:
                                          Text(newData[index].truckDisplayName),
                                      subtitle: Text(
                                        'Last update: ${newData[index].date} ${newData[index].formattedTime}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _vehicleController.text =
                                              newData[index].truckDisplayName;
                                          _vehicleImei = newData[index].imei;
                                          // _vehicleController.value =
                                          //     newData[index].imei;
                                        });
                                      },
                                    );
                                  }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.02),
                    Expanded(
                      child: SlideTransition(
                        position: _offsetAnimation,
                        child: Container(
                          alignment: Alignment.center,
                          width: constraints.maxWidth * 0.6, // Adjust as needed
                          height: screenHeight * 0.8,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: themeModel.mode == ThemeMode.light
                                ? secondaryColor
                                : lightSecondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20,
                                offset: Offset(0, 10),
                                spreadRadius: 16,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    color: themeModel.mode == ThemeMode.light
                                        ? secondaryColor
                                        : lightSecondaryColor,
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.title,
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        // Your custom text fields and buttons can be added here
                                        Focus(
                                          onFocusChange: (hasFocus) {
                                            // The focus has changed, update the icon color
                                            setState(() {});
                                          },
                                          child: SizedBox(
                                            width: 600,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Vehicle Number.',
                                                  suffixIcon: SvgPicture.asset(
                                                      'assets/icons/truck.svg')),
                                              controller: _vehicleController,
                                              // readOnly: true,
                                            ),
                                          ),
                                        ),

                                        // DynamicTextField(
                                        //   hintText: 'Password',
                                        //   labelText: 'Password',
                                        //   icon: CupertinoIcons.lock_circle,
                                        //   width: 260,
                                        //   fontSize: 18,
                                        //   obscureText: true,
                                        //   controller: passwordController,
                                        // ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        buildFields(),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        _button()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    _fromDateController.dispose();
    _searchController.dispose();
    _toDateController.dispose();
    _vehicleController.dispose();

    super.dispose();
  }

  Widget buildFields() {
    return Wrap(
      runSpacing: 10,
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            controller: _fromDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'From Date/Time',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  _selectDate(context, _fromDateController);
                },
                icon: Icon(Icons.calendar_month),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 300,
          child: TextField(
            controller: _toDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'To Date/Time',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  _selectDate(context, _toDateController);
                },
                icon: Icon(Icons.calendar_month),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _button() {
    return StylizedButton(
      label: 'Fetch Report',
      onPressed: () async {
        if (widget.path == 'movement') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => VehicleLogs(
                imei: _vehicleImei,
                from_date: _fromDateController.text,
                to_date: _toDateController.text,
                displayName: _vehicleController.text,
              ),
            ),
          );
        } else if (widget.path == 'eseals') {}
      },
      startColor: Colors.blue,
      endColor: Colors.blue,
    );
  }
}
