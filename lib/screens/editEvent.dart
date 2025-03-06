import 'package:evently_app/models/category.dart';
import 'package:evently_app/models/eventmodel.dart';
import 'package:evently_app/pages/home/tabItem.dart';
import 'package:evently_app/providers/event_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/services/firebaseServices.dart';
import 'package:evently_app/theme/apptheme.dart';
import 'package:evently_app/widgets/custombutton.dart';
import 'package:evently_app/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late Event event;
  int currrentindex = 0;
  Categoryy selectedCategory = Categoryy.categories.first;
  TextEditingController titleController = TextEditingController();
  TextEditingController describtionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat selectedDateFormat = DateFormat('dd/MM/yyyy');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.settingsOf(context)!.arguments as Event;
    selectedCategory = event.category;
    currrentindex = Categoryy.categories.indexOf(event.category);
    TextTheme texttheme = Theme.of(context).textTheme;
    // ignore: unused_local_variable
    var screendim = MediaQuery.sizeOf(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.primary,
        ),
        backgroundColor: AppTheme.white,
        centerTitle: true,
        title: Text(
          'Create Event',
          style: texttheme.displayMedium?.copyWith(
            color: AppTheme.primary,
          ),
        ),
      ),
      body: DefaultTabController(
        length: Categoryy.categories.length,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screendim.height * 0.235,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/image/${selectedCategory.imageName}.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TabBar(
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    labelPadding: EdgeInsets.only(right: 10),
                    isScrollable: true,
                    onTap: (index) {
                      currrentindex = index;
                      selectedCategory = Categoryy.categories[currrentindex];
                      setState(() {});
                    },
                    tabs: Categoryy.categories
                        .map(
                          (category) => TabItem(
                            selectedcolor: AppTheme.primary,
                            unselectedcolor: AppTheme.white,
                            icon: category.icon,
                            text: category.text,
                            isSelected: currrentindex ==
                                    Categoryy.categories.indexOf(category)
                                ? true
                                : false,
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'text',
                    style: texttheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    imagepath: 'assets/SVG/Note_Edit.svg',
                    hinttext: 'Event Title',
                    controller: titleController,
                    onChanged: (value) => titleController.text = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Event Title cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Description',
                    style: texttheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    maxlines: 5,
                    hinttext: 'Event Description',
                    controller: describtionController,
                    onChanged: (value) => describtionController.text = value,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/SVG/Calendar_Days.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Event Date',
                        style: texttheme.bodyLarge,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            initialEntryMode: DatePickerEntryMode.calendar,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              Duration(
                                days: 730,
                              ),
                            ),
                          );
                          if (date != null) {
                            setState(() {
                              selectedDate = date;
                            });
                          }
                        },
                        child: Text(
                          selectedDate == null
                              ? 'Choose Date'
                              : selectedDateFormat.format(selectedDate!),
                          style: texttheme.bodyLarge?.copyWith(
                            color: AppTheme.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/SVG/Clock.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Event Time',
                        style: texttheme.bodyLarge,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              selectedTime = time;
                            });
                          }
                        },
                        child: Text(
                          selectedTime == null
                              ? 'Choose Time'
                              : selectedTime!.format(context),
                          style: texttheme.bodyLarge?.copyWith(
                            color: AppTheme.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Location',
                    style: texttheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.primary),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            style: IconButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: Icon(
                              Icons.my_location_rounded,
                            ),
                            color: AppTheme.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Choose Event Location',
                            style: texttheme.bodyLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    screendim: screendim,
                    text: 'Add Event',
                    onpressed: createEvent,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createEvent() {
    if (formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      Event event = Event(
        title: titleController.text,
        userId:
            Provider.of<UserProvider>(context, listen: false).currnetUser!.id,
        describtion: describtionController.text,
        category: selectedCategory,
        dateTime: dateTime,
      );
      FireBaseServices.addEventsToFirestore(event).then((_) {
        Provider.of<EventsProvider>(context, listen: false)
            .getEventsToCategory();
        Navigator.of(context).pop();
      }).catchError(
        (_) => print('faild to create event'),
      );
    }
  }
}
