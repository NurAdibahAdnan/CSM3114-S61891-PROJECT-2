import 'package:school_management_app/model/discipline_category.dart';

class DisciplineReport {
  const DisciplineReport({
    required this.id,
    required this.name,
    required this.reasons,  // Changed to List<String>
    required this.disciplineStatus,
  });

  final String id;
  final String name;
  final List<String> reasons;  // Change String to List<String>
  final DisciplineStatusData disciplineStatus;
}
