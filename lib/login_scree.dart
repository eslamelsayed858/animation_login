import 'package:anemd/animation_enum.dart';
import 'package:anemd/class.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Artboard? riveArtboard;

  late RiveAnimationController controlleridle;
  late RiveAnimationController controllerhat_down;
  late RiveAnimationController controllerhat_up;
  late RiveAnimationController controllerhat_idle;
  late RiveAnimationController controllerhigh;
  late RiveAnimationController controllerlow;
  late RiveAnimationController controllerfocusOnText;
  late RiveAnimationController controllerunFicusOnText;
  late RiveAnimationController controllerblink;

  bool isLookingLeft = false;
  bool isLookingRigt = false;

  void removeAllControllers() {
    riveArtboard?.artboard.removeController(controlleridle);
    riveArtboard?.artboard.removeController(controllerhat_down);
    riveArtboard?.artboard.removeController(controllerhat_up); //
    riveArtboard?.artboard.removeController(controllerhat_idle);
    riveArtboard?.artboard.removeController(controllerhigh);
    riveArtboard?.artboard.removeController(controllerlow);
    riveArtboard?.artboard.removeController(controllerfocusOnText);
    riveArtboard?.artboard.removeController(controllerunFicusOnText);
    riveArtboard?.artboard.removeController(controllerblink);

    isLookingLeft = false;
    isLookingRigt = false;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String testEmail = 'eslam@gmail.com';
  String testPassword = '12345';
  final emailfocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  void addIdleController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controlleridle); ///////////////
    debugPrint('idleee');
  }

  void addrhatdownController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerhat_down); ///////////////
    debugPrint('idleee');
  }

  void addhatupController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerhat_up); ///////////////
    debugPrint('idleee');
  }

  void addhatidleController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerhat_idle); ///////////////
    debugPrint('idleee');
  }

  void addhighController() {
    removeAllControllers();
    isLookingRigt = true;
    riveArtboard?.artboard.addController(controllerhigh); ///////////////
    debugPrint('idleee');
  }

  void addlowController() {
    removeAllControllers();
    isLookingLeft = true;
    riveArtboard?.artboard.addController(controllerlow); ///////////////
    debugPrint('idleee');
  }

  void addfocusOnTextController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerfocusOnText); ///////////////
    debugPrint('idleee');
  }

  void addFicusOnTextController() {
    removeAllControllers();
    riveArtboard?.artboard
        .addController(controllerunFicusOnText); ///////////////
    debugPrint('idleee');
  }

  void addblinkController() {
    removeAllControllers();
    riveArtboard?.artboard.addController(controllerblink); ///////////////
    debugPrint('idleee');
  }

  void checkForPasswordFocusNodeToChangeAnimationState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        addrhatdownController();
      } else if (!passwordFocusNode.hasFocus) {
        addhatupController();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    controlleridle = SimpleAnimation(AnimationEnum.idle.name);
    controllerhat_down = SimpleAnimation(AnimationEnum.hat_down.name);
    controllerhat_up = SimpleAnimation(AnimationEnum.hat_up.name);
    controllerhat_idle = SimpleAnimation(AnimationEnum.hat_idle.name);
    controllerhigh = SimpleAnimation(AnimationEnum.high.name);
    controllerlow = SimpleAnimation(AnimationEnum.low.name);
    controllerfocusOnText = SimpleAnimation(AnimationEnum.focusOnText.name);
    controllerunFicusOnText = SimpleAnimation(AnimationEnum.focusOnText.name);
    controllerblink = SimpleAnimation(AnimationEnum.blink.name);

    rootBundle.load('assets/login_animathion.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controllerfocusOnText); ////////

      setState(() {
        riveArtboard = artboard;
      });
    });
    checkForPasswordFocusNodeToChangeAnimationState();
  }

  void volidateEmilAndPassword() {
    if (formKey.currentState!.validate()) {
      addblinkController();
    } else {
      addIdleController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Animated',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: riveArtboard == null
                    ? const SizedBox.shrink()
                    : Rive(
                        artboard: riveArtboard!,
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      validator: (value) =>
                          value != testEmail ? "wrong emil" : null,
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            value.length < 14 &&
                            !isLookingLeft) {
                          addlowController();
                        } else if (value.isNotEmpty &&
                            value.length > 14 &&
                            !isLookingRigt) {
                          addhighController();
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      focusNode: passwordFocusNode,
                      validator: (value) =>
                          value != testPassword ? "wrong password" : null,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 7,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 14)),
                        onPressed: () {
                          passwordFocusNode.unfocus();

                          if (formKey.currentState!.validate()) {
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return const Screenshat();
                                },
                              ));
                            });
                          }
                          volidateEmilAndPassword();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
