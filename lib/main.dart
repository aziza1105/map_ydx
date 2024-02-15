import 'features/bloc/map_bloc.dart';
import 'features/map_permission.dart';
import 'features/presentation/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await permission();
  runApp(const YandexMapApp());}

class YandexMapApp extends StatelessWidget {
  const YandexMapApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RouteBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyMapScreen()));
  }}
