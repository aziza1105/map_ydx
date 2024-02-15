import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../bloc/map_bloc.dart';

class MyMapScreen extends StatefulWidget {
  const MyMapScreen({super.key});

  @override
  State<MyMapScreen> createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen> {
  Location location = Location();
  @override
  void initState() {
    location.onLocationChanged.listen((event) {
      context.read<RouteBloc>().add(LocationBloc());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteBloc, RouteState>(
      builder: (context, state) {
        return Builder(builder: (context) {
          if (state.status == Status.loading) {
            context.read<RouteBloc>().add(LocationBloc());
            return const CupertinoActivityIndicator();
          } else if (state.status == Status.success) {
            return Scaffold(
              body: YandexMap(
                mapObjects: [
                  CircleMapObject(
                    fillColor: Colors.blue.withOpacity(.3),
                    mapId: const MapObjectId("source"),
                    strokeColor: Colors.blue,
                    circle: Circle(
                      center: state.myLocation,
                      radius: 15)),
                  PlacemarkMapObject(
                    mapId: const MapObjectId("destination"),
                    point: state.destination,
                      icon: PlacemarkIcon.single(PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage('aziza.jpg'),
                        scale: .05))),
                  state.route],
                onMapCreated: (controller) async {
                  state.controller = controller;
                  await controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: state.myLocation,
                        zoom: 17)));
                }));
          } else {
            return const Scaffold(
              body: Center(
                child: Text("Empty")));
          }});
      });
  }}
