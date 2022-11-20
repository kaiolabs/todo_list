import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/core/presenters/theme/font_family_outlet.dart';
import 'package:todo_list/src/core/presenters/theme/size_outlet.dart';
import 'package:todo_list/src/core/repositories/db.dart';
import 'package:todo_list/start_app.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                builder: (context, double value, child) {
                  return AnimatedOpacity(
                    opacity: value,
                    onEnd: () {
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          DB.getLogged().then((value) {
                            if (value) {
                              Modular.to.navigate('/base/');
                            } else {
                              Modular.to.push(
                                MaterialPageRoute(
                                  builder: (context) => const StartApp(),
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                    duration: const Duration(milliseconds: 600),
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: Image.asset(
                    'assets/images/task.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              top: MediaQuery.of(context).size.height * 0.8,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                builder: (context, double value, child) {
                  return AnimatedOpacity(
                    opacity: value,
                    duration: const Duration(milliseconds: 600),
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Image.asset(
                        'assets/images/infinidade.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Text(
                      'Infinite Studios',
                      style: TextStyle(
                        fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
                        fontSize: SizeOutlet.textSizeMicro1,
                        color: ColorOutlet.colorPrimaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
