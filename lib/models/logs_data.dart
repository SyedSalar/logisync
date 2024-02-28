import 'package:intl/intl.dart';

class UserData {
  final int id;
  final String imei;
  final double latitude;
  final double longitude;
  final int speed;
  final String packetStatus;
  final String date;
  final String time;
  final String icon;
  final String statuses;
  final String checks;
  final String truckDisplayName;

  UserData(
      {required this.id,
      required this.imei,
      required this.latitude,
      required this.longitude,
      required this.speed,
      required this.packetStatus,
      required this.date,
      required this.time,
      required this.statuses,
      required this.checks,
      required this.truckDisplayName,
      required this.icon});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        imei: json['imei'],
        latitude: double.parse(json['latitude']),
        longitude: double.parse(json['longitude']),
        speed: int.parse(json['speed']),
        packetStatus: json['packetStatus'],
        date: json['date'],
        time: json['time'],
        checks: json['checks'],
        statuses: json['statuses'] ?? '',
        truckDisplayName: json['truckName'] ?? 'No Name',
        icon: 'assets/icons/truck.svg');
  }
  String get formattedTime {
    final parsedTime = DateTime.parse('1970-01-01 $time');
    final formattedTime = DateFormat.jm().format(parsedTime);
    return formattedTime;
  }
}

class CombinedModel {
  final int imeiLogId;
  final String imei;
  final double latitude;
  final double longitude;
  final int speed;
  final String packetStatus;
  final String date;
  final String time;
  final String statuses;
  final String checks;
  final int truckId;
  final String haulierId;
  final String truckDisplayName;
  final String icon;

  CombinedModel(
      {required this.imeiLogId,
      required this.imei,
      required this.latitude,
      required this.longitude,
      required this.speed,
      required this.packetStatus,
      required this.date,
      required this.time,
      required this.statuses,
      required this.checks,
      required this.truckId,
      required this.haulierId,
      required this.truckDisplayName,
      required this.icon});

  factory CombinedModel.fromJson(Map<String, dynamic> json) {
    return CombinedModel(
        imeiLogId: json['imei_log']['id'],
        imei: json['imei_log']['imei'],
        latitude: double.parse(json['imei_log']['latitude']),
        longitude: double.parse(json['imei_log']['longitude']),
        speed: int.parse(json['imei_log']['speed']),
        packetStatus: json['imei_log']['packetStatus'],
        date: json['imei_log']['date'],
        time: json['imei_log']['time'],
        statuses: json['imei_log']['statuses'],
        checks: json['imei_log']['checks'],
        truckId: json['truck']['id'],
        haulierId: json['truck']['haulier'],
        truckDisplayName: json['truck']['display_name'],
        icon: 'assets/icons/truck.svg');
  }
  String get formattedTime {
    final parsedTime = DateTime.parse('1970-01-01 $time');
    final formattedTime = DateFormat.jm().format(parsedTime);
    return formattedTime;
  }
}

class MyUserModel {
  final String username;
  final String email;
  final String role;
  final String id;

  MyUserModel(
      {required this.username,
      required this.email,
      required this.role,
      required this.id});
}
