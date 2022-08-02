/*
 * Copyright (c) Bholendra Singh 2022.
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seatgeek/services/apis/api_response.dart';

import '../model/events_repository.dart';

class EventsViewModel with ChangeNotifier {
  final inputController = TextEditingController();
  ApiResponse apiResponse = ApiResponse.initial('Empty data');

  Future<void> fetchEvents(String value) async {
    apiResponse = ApiResponse.loading('Fetching events data');
    notifyListeners();
    try {
      var eventsModel = await EventsRepository().fetchEventsList(value);
      apiResponse = ApiResponse.completed(eventsModel);
    } catch (e) {
      apiResponse = ApiResponse.error(e.toString());
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  void clearData() {
    apiResponse = ApiResponse.initial('Empty data');
    inputController.clear();
    notifyListeners();
  }
}
