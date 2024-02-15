part of 'map_bloc.dart';

class RouteState {
  final Point destination;
  final Point myLocation;
  final PolylineMapObject route;
  final Status status;
  YandexMapController? controller;

  RouteState({
    required this.destination,
    required this.myLocation,
    required this.route,
    required this.status,
    this.controller,
  });

  RouteState copyWith({
    Point? destinationPoint,
    Point? myLocationPoint,
    PolylineMapObject? route,
    Status? status,
    YandexMapController? controller,
  })
  {
    return RouteState(
      destination: destinationPoint ?? destination,
      myLocation: myLocationPoint ?? myLocation,
      route: route ?? this.route,
      status: status ?? this.status,
      controller: controller ?? this.controller,
    );
  }
}
enum Status {
  loading,
  success,
}
