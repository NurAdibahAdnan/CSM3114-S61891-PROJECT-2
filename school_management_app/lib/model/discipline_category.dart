import 'dart:ui';

import 'package:flutter/material.dart';

enum DisciplineStatus {
  Good,
  UnderSupervision,
  Reprimanded,
}

class DisciplineStatusData {
  final DisciplineStatus status;
  final String label;
  final Color color;

  DisciplineStatusData({
    required this.status,
    required this.label,
    required this.color,
  });

  // Convert the object to a map
  Map<String, dynamic> toJson() {
    return {
      'status': status.toString().split('.').last,
      'label': label,
      'color': color.value,
    };
  }

  // Create an instance from a JSON map
  factory DisciplineStatusData.fromJson(Map<String, dynamic> json) {
    return DisciplineStatusData(
      status: _parseDisciplineStatus(json['status']),
      label: json['label'],
      color: Color(json['color']),
    );
  }

  // Helper method to convert a string to DisciplineStatus enum
  static DisciplineStatus _parseDisciplineStatus(String status) {
    switch (status) {
      case 'Good':
        return DisciplineStatus.Good;
      case 'UnderSupervision':
        return DisciplineStatus.UnderSupervision;
      case 'Reprimanded':
        return DisciplineStatus.Reprimanded;
      default:
        throw ArgumentError('Invalid DisciplineStatus: $status');
    }
  }

  static Color getColor(DisciplineStatus status) {
    switch (status) {
      case DisciplineStatus.Good:
        return Colors.green;
      case DisciplineStatus.UnderSupervision:
        return Colors.yellow;
      case DisciplineStatus.Reprimanded:
        return Colors.red;
    }
  }
}
