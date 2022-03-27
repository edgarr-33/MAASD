// To parse this JSON data, do
//
//     final monitorModel = monitorModelFromJson(jsonString);

import 'dart:convert';

MonitorModel monitorModelFromJson(String str) => MonitorModel.fromJson(json.decode(str));

String monitorModelToJson(MonitorModel data) => json.encode(data.toJson());

class MonitorModel {
    MonitorModel({
        required this.fLatitude,
        required this.fLongitude,
        required this.fTemperature,
        required this.fBpm,
    });

    double fLatitude;
    double fLongitude;
    double fTemperature;
    int fBpm;

    factory MonitorModel.fromJson(Map<String, dynamic> json) => MonitorModel(
        fLatitude: json["f_latitude"].toDouble(),
        fLongitude: json["f_longitude"].toDouble(),
        fTemperature: json["f_temperature"].toDouble(),
        fBpm: json["f_bpm"],
    );

    Map<String, dynamic> toJson() => {
        "f_latitude": fLatitude,
        "f_longitude": fLongitude,
        "f_temperature": fTemperature,
        "f_bpm": fBpm,
    };
}
