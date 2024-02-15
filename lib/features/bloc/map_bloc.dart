import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'map_event.dart';
part 'map_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc() : super(
          RouteState(
            route: const PolylineMapObject(
              mapId: MapObjectId('my_location'),
              polyline: Polyline(
                points: [])),
            status: Status.loading,
            destination: const Point(latitude: 41.2858305, longitude: 69.2035464),
            myLocation: const Point(latitude: 0, longitude: 0))) {
    on<LocationBloc>((event, emit) async {
      var point = await Location().getLocation();
      emit(state.copyWith(myLocationPoint:
            Point(latitude: point.latitude!,
                longitude: point.longitude!),
        status: Status.success));
      final request = YandexDriving.requestRoutes(
        points: [
          RequestPoint(
            point: state.myLocation,
            requestPointType: RequestPointType.wayPoint),
          RequestPoint(
            point: state.destination,
            requestPointType: RequestPointType.wayPoint)],
        drivingOptions: const DrivingOptions(
          initialAzimuth: 0,
          routesCount: 1,
          avoidTolls: true));
      final result = await request.result;
      emit(state.copyWith(
        route: PolylineMapObject(
          strokeColor: Colors.red,
          strokeWidth: 5,
          mapId: const MapObjectId("my_location"),
          polyline: Polyline(points: result.routes?.first.geometry ?? []))));
    });
  }}
