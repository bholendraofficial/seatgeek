/*
 * Copyright (c) Bholendra Singh 2022.
 */

import 'package:seatgeek/model/events_model.dart';
import 'package:seatgeek/services/web_service.dart';

class EventsRepository {
  final WebService webService = WebService();

  Future<EventsModel> fetchEventsList(String value) async {
    dynamic response = await webService.getResponse(
        "events?client_id=MjgxODgwNjd8MTY1OTM3MTE2MC40MzkxMzU&q=$value");
    EventsModel eventsModel = EventsModel.fromJson(response);
    return eventsModel;
  }
}
