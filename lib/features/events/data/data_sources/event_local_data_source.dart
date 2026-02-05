import 'dart:convert';
import 'package:flutter/services.dart';

class EventLocalDataSource {
  Future<List<Map<String, dynamic>>> loadEvents() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/events.json');
      final List decoded = json.decode(jsonString);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception("Invalid JSON or missing file");
    }
  }
}
