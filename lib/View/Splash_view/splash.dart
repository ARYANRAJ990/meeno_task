import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memoneet_task2/Res/Component/colors.dart';
import 'package:provider/provider.dart';
import '../../Utils/Routes/routes_name.dart';
import '../telegram_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _textAnimation;
  String _animatedText = "Line By Line NCERT";

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        await context.read<TelegramProvider>().getTelegramData().then((value) {
          if (context.read<TelegramProvider>().telegramUser != null) {
           // context
              //  .read<UserViewModel>()
             //   .initWithTg(context.read<TelegramProvider>().telegramUser!);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Telegram data is null'),
              ),
            );
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error in getting telegram data: $e'),
          ),
        );
      }
    });
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _textAnimation = StepTween(
      begin: 0,
      end: _animatedText.length,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _controller.forward();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RoutesName.notes);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'images/neet.jpeg',
                height: 200.w, // Responsive width
                width: 200.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Memoneet',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48.sp,
                color: AppColors.blueColor,
              ),
            ),
            SizedBox(height: 12.h),
            AnimatedBuilder(
              animation: _textAnimation,
              builder: (context, child) {
                return Text(
                  _animatedText.substring(0, _textAnimation.value),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.sp,
                    color: AppColors.blueColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
