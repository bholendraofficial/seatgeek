/*
 * Copyright (c) Bholendra Singh 2022.
 */

import 'package:flutter/material.dart';
import 'package:seatgeek/model/events_model.dart';
import 'package:seatgeek/utils/utils.dart';

class EventsDetailsScreen extends StatefulWidget {
  Events events;

  EventsDetailsScreen({Key? key, required this.events}) : super(key: key);

  @override
  State<EventsDetailsScreen> createState() => _EventsDetailsScreenState();
}

class _EventsDetailsScreenState extends State<EventsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text(
          widget.events.title!,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            Image.network(
              widget.events.performers!.first.image!,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              Utils.parseDateTime(widget.events.datetimeLocal!),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "${widget.events.venue!.city!}, ${widget.events.venue!.country!}",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      )),
    );
  }
}
