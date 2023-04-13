import 'package:doctorapp/model/timeschedule.dart';

class WorkSlotModel {
  String startTime = "", endTime = "", durationGap = "";
  List<TimeScheduleModel> timeSchedule = [];

  String get getStartTime {
    return startTime;
  }

  set setStartTime(String startTime) {
    this.startTime = startTime;
  }

  String get getEndTime {
    return endTime;
  }

  set setEndTime(String endTime) {
    this.endTime = endTime;
  }

  set setDurationGap(String durationGap) {
    this.durationGap = durationGap;
  }

  String get getDurationGap {
    return durationGap;
  }

  List<TimeScheduleModel> get getTimeSchedule {
    return timeSchedule;
  }

  set setTimeSchedule(List<TimeScheduleModel> timeSchedule) {
    this.timeSchedule = timeSchedule;
  }
}
