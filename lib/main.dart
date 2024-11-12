import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memoneet_task2/Utils/Routes/routes.dart';
import 'package:memoneet_task2/Utils/Routes/routes_name.dart';
import 'package:memoneet_task2/View/biology_view.dart';
import 'package:memoneet_task2/View/chemistry_view.dart';
import 'package:memoneet_task2/View/physics_view.dart';
import 'package:memoneet_task2/View/chat_bot.dart';
import 'package:provider/provider.dart';
import 'View/telegram_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TelegramProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Memoneet',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
          routes: {
            '/physics': (context) => const physics_notes(),
            '/chemistry': (context) => const chemistry_notes(),
            '/biology': (context) => const biology_notes(),
            '/chatbot': (context) => const chat_view(),
          },
        );
      },
    );
  }
}
