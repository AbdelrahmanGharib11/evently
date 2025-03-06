import 'package:evently_app/models/eventmodel.dart';
import 'package:evently_app/models/usermodel.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat selectedDateFormat = DateFormat('dd MMMM yyyy');
    DateFormat selectedTimeFormat = DateFormat('h:mm a');
    Event event = ModalRoute.settingsOf(context)!.arguments as Event;
    var screendim = MediaQuery.sizeOf(context);
    TextTheme texttheme = Theme.of(context).textTheme;
    UserModel? currentUser = Provider.of<UserProvider>(context).currnetUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        foregroundColor: AppTheme.primary,
        centerTitle: true,
        title: Text('Event Details'),
        actions: [
          currentUser!.id == event.userId
              ? Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_calendar_rounded,
                        color: AppTheme.primary,
                        size: 22,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('editevent', arguments: event);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: AppTheme.red,
                        size: 22,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              : IconButton(
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: AppTheme.red,
                    size: 22,
                  ),
                  onPressed: () {},
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                      'assets/image/${event.category.imageName}.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                event.title,
                softWrap: true,
                style: texttheme.displaySmall?.copyWith(
                  color: AppTheme.primary,
                ),
              ),
              SizedBox(height: 16),
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
                          Icons.date_range,
                        ),
                        color: AppTheme.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedDateFormat.format(event.dateTime),
                            style: texttheme.bodyLarge?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          Text(
                            selectedTimeFormat.format(event.dateTime),
                            style: texttheme.bodyLarge?.copyWith(
                              color: AppTheme.black,
                            ),
                          ),
                        ],
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              Text(
                'Description',
                softWrap: true,
                style: texttheme.bodyLarge?.copyWith(
                  color: AppTheme.black,
                ),
              ),
              SizedBox(height: 16),
              Text(
                event.describtion,
                softWrap: true,
                style: texttheme.bodyLarge?.copyWith(
                  color: AppTheme.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
