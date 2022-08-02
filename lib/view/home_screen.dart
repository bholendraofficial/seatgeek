/*
 * Copyright (c) Bholendra Singh 2022.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seatgeek/model/events_model.dart';
import 'package:seatgeek/services/apis/api_response.dart';
import 'package:seatgeek/view_model/events_view_model.dart';

import '../utils/utils.dart';
import 'event_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final EventsViewModel eventsViewModel =
        Provider.of<EventsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          child: TextField(
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              controller: eventsViewModel.inputController,
              onChanged: (value) {
                if (value.isEmpty) {
                  eventsViewModel.clearData();
                }
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  eventsViewModel.fetchEvents(value);
                } else {
                  eventsViewModel.clearData();
                }
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      eventsViewModel.clearData();
                    },
                  ),
                  hintText: 'Enter Events Name',
                  hintStyle: const TextStyle(color: Colors.grey))),
        ),
      ),
      body: SafeArea(child: Builder(
        builder: (BuildContext context) {
          switch (eventsViewModel.apiResponse.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.COMPLETED:
              EventsModel eventsModel = eventsViewModel.apiResponse.data;
              return ListView.separated(
                itemCount: eventsModel.events!.length,
                itemBuilder: (BuildContext context, int index) {
                  Events events = eventsModel.events!.elementAt(index);
                  return ListTile(
                    onTap: () {
                      navigateToDetails(events);
                    },
                    title: Text(
                      events.title!,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "${events.venue!.city!}, ${events.venue!.country!}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(Utils.parseDateTime(events.datetimeLocal!)),
                      ],
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        events.performers!.first.image!,
                        height: kToolbarHeight,
                        width: kToolbarHeight,
                        fit: BoxFit.fill,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(12.0),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                    height: 1,
                  );
                },
              );
            case Status.ERROR:
              return const Center(
                child: Text('Please try again latter!!!'),
              );
            case Status.INITIAL:
            default:
              return const Center(
                child: Text('Search the events by Name'),
              );
          }
        },
      )),
    );
  }

  void navigateToDetails(Events events) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EventsDetailsScreen(events: events)),
    );
  }
}
