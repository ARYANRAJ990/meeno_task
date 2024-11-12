import 'package:flutter/material.dart';
import 'package:memoneet_task2/Utils/Routes/routes_name.dart';
import 'package:memoneet_task2/View/chapters/chem_chapters.dart';
import 'package:memoneet_task2/View/chat_bot.dart';
import 'package:memoneet_task2/View/biology_view.dart';
import 'package:memoneet_task2/View/notes_view.dart';

import '../../View/Splash_view/splash.dart';
import '../../View/chemistry_view.dart';
import '../../View/physics_view.dart';
class Routes{
  static Route<dynamic> generateRoute(RouteSettings setting){

    switch(setting.name){
    case RoutesName.splash:
    return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

      case RoutesName.notes:
        return MaterialPageRoute(builder: (BuildContext context) => const Notes());

        case RoutesName.biology:
          return MaterialPageRoute(builder: (BuildContext context) => const biology_notes());

      case RoutesName.chemistry:
        return MaterialPageRoute(builder: (BuildContext context) => const chemistry_notes());

      case RoutesName.physics:
        return MaterialPageRoute(builder: (BuildContext context) => const physics_notes());

       case RoutesName.chatbot:
        return MaterialPageRoute(builder: (BuildContext context) => const chat_view());

      case RoutesName.chem: // Route for bio_view page with arguments
        final args = setting.arguments as Map<String, String>;
        final topics = args['topics'] ?? '';
        return MaterialPageRoute(
          builder: (BuildContext context) => chem_view( topicName: '',),
        );

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('no route'),
            ),
          );
        });
    };}}
