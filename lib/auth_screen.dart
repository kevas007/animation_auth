import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_auth_animation/constants.dart';
import 'package:flutter_auth_animation/widgets/login_form.dart';
import 'package:flutter_auth_animation/widgets/sign_up_form.dart';
import 'package:flutter_auth_animation/widgets/socal_buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin
{
//condition
  bool _isShowSingUp= false;
  late  AnimationController _animationController;

  late Animation<double> _animationTextRotate;


  void setUpAnimation(){
    _animationController = AnimationController(vsync: this, duration: defaultDuration);
    
    _animationTextRotate =  Tween<double>(begin: 0, end: 90).animate(_animationController);
       
  }

  void updateView(){
    setState((){
      _isShowSingUp = ! _isShowSingUp;
    });
    _isShowSingUp ? _animationController.forward() : _animationController.reverse();
  }

  @override
  void initState(){
    setUpAnimation();

    super.initState();
  }
  @override
   void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: [
              //login
              AnimatedPositioned(
                duration: defaultDuration,
                //width 88%
                width: _size.width *0.88, //88%
                height: _size.height,
                left:_isShowSingUp ? -_size.width * 0.76: 0,
                child: Container(
                color: login_bg,
                  child: LoginForm(),
          ),
              ),
              //sing up
              AnimatedPositioned(
                duration: defaultDuration,
              height: _size.height,
              width: _size.width * 0.88,
              left: _isShowSingUp ? _size.width * 0.12 : _size.width * 0.88,

              child: Container(
                color: signup_bg,
                child: SignUpForm(),
              )  ,
            ),



              //logo
              AnimatedPositioned(
                duration: defaultDuration,
                left: 0,
                top: _size.height * 0.1,
                right: _isShowSingUp ? -_size.width* 0.06: _size.width* 0.06 ,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white60,
                  child: AnimatedSwitcher(
                    duration: defaultDuration,
                    child: _isShowSingUp ?
                    SvgPicture.asset(
                      "assets/animation_logo.svg",
                      color: login_bg,
                    ) :
                    SvgPicture.asset(
                      "assets/animation_logo.svg",
                      color: login_bg,
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration:  defaultDuration,
                width: _size.width,
                bottom: _size.height *0.1,
                right: _isShowSingUp ? -_size.width* 0.06: _size.width* 0.06 ,

                child: SocalButtns(),
              ),

              //login Text
              AnimatedPositioned(
                duration:  defaultDuration,
                bottom: _isShowSingUp ?  _size.height /2 - 80 :  _size.height * 0.3,
                left: _isShowSingUp ? 0: _size.width * 0.44 - 80,
                child: AnimatedDefaultTextStyle(
                  duration:  defaultDuration,
                  textAlign:  TextAlign.center,
                  style: TextStyle(
                    fontSize: _isShowSingUp ? 18 : 32,
                    fontWeight: FontWeight.bold,
                    color: _isShowSingUp ? Colors.white: Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle: - _animationTextRotate.value * pi /180,
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: (){
                        if(_isShowSingUp){
                          updateView();
                        }
                        else{
                          //login
                        }
                      },
                      child: Container(

                        width: 160,
                        padding: const EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                        child: Text(
                          'Log In'.toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ),

              ),

              //Sing up

              AnimatedPositioned(
                duration:  defaultDuration,
                bottom: ! _isShowSingUp ?  _size.height /2 - 80 :  _size.height * 0.3,
                right: _isShowSingUp ?  _size.width * 0.44 - 80 :0 ,
                child: AnimatedDefaultTextStyle(
                  duration:  defaultDuration,
                  textAlign:  TextAlign.center,
                  style: TextStyle(
                    fontSize: !_isShowSingUp ? 18 : 32,
                    fontWeight: FontWeight.bold,
                    color: _isShowSingUp ? Colors.white: Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle:( 90 - _animationTextRotate.value) * pi /180,
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap:(){
                        if(_isShowSingUp){
                        // sign up
                        }
                        else{
                          updateView();
                        }
                      },
                      child: Container(

                        width: 160,
                        padding: const EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                        child: Text(
                          'Sign up'.toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ),

              ),
            ],
          );
        }
      ),
    );
  }
}

