import 'package:flutter/material.dart';
import 'package:pictorama/features/dashboard/presenter/pages/dashboard_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictorama/features/dashboard/presenter/cubit/dashboard_cubit.dart';
import 'package:pictorama/injection_container.dart';
import 'package:pictorama/injection_container.dart' as di;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCubit>(
          create: (BuildContext context) => sl.get<DashboardCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Pictorama',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DashBoardScreen(),
      ),
    );
  }
}
