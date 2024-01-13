import 'package:school_management_app/model/discipline_category.dart';
import 'package:flutter/material.dart';

final disciplineStatusData = {
  DisciplineStatus.Good: DisciplineStatusData(
    status: DisciplineStatus.Good,
    label: 'Good',
    color: Colors.green,
  ),
  DisciplineStatus.UnderSupervision: DisciplineStatusData(
    status: DisciplineStatus.UnderSupervision,
    label: 'Under Supervision',
    color: Colors.yellow,
  ),
  DisciplineStatus.Reprimanded: DisciplineStatusData(
    status: DisciplineStatus.Reprimanded,
    label: 'Reprimanded',
    color: Colors.red,
  ),
};


