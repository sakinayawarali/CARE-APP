import 'dart:developer';
import 'package:care_app/screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CustomSplashScreenView extends StatefulWidget {
  final String? imageSrc;
  final Duration duration;
  final double logoSize;
  final Duration speed;
  final PageRouteTransition? pageRouteTransition;
  final EdgeInsets paddingText;
  final AnimatedText? text;
  final Color backgroundColor;
  final LinearGradient? linearGradient;
  final EdgeInsets paddingLoading;
  final bool displayLoading;

  const CustomSplashScreenView({
    super.key,
    this.imageSrc = 'lib/assets/IMG_4555.PNG', // Default image path
    this.backgroundColor = Colors.white,
    this.linearGradient,
    this.duration = const Duration(milliseconds: 3000),
    this.logoSize = 400,
    this.speed = const Duration(milliseconds: 1000),
    this.pageRouteTransition,
    this.paddingText = const EdgeInsets.only(right: 10, left: 10, top: 20),
    this.text,
    this.paddingLoading = const EdgeInsets.only(bottom: 100),
    this.displayLoading = true,
  });

  @override
  State<CustomSplashScreenView> createState() => _CustomSplashScreenViewState();
}

class _CustomSplashScreenViewState extends State<CustomSplashScreenView>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController? _animationController;
  bool _isNetworkImage = false;
  bool _isLottie = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.easeInCirc));

    _animationController!.forward();

    if (widget.imageSrc != null && widget.imageSrc!.isNotEmpty) {
      _isNetworkImage = widget.imageSrc!.startsWith("http://") ||
          widget.imageSrc!.startsWith("https://");
      _isLottie = widget.imageSrc!.endsWith(".json");
    }

    log("widget._isNetworkImage $_isNetworkImage");

    Future.delayed(
      Duration(milliseconds: widget.duration.inMilliseconds + 2000),
    ).then((_) => _navigateToNextScreen());
  }

  void _navigateToNextScreen() {
    if (!mounted) return;

    switch (widget.pageRouteTransition) {
      case PageRouteTransition.Normal:
        Navigator.of(context).pushReplacement(_normalPageRoute());
        break;
      case PageRouteTransition.CupertinoPageRoute:
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (BuildContext context) => const LoginScreen()));
        break;
      case PageRouteTransition.SlideTransition:
        Navigator.of(context).pushReplacement(_tweenAnimationPageRoute());
        break;
      default:
        Navigator.of(context).pushReplacement(_normalPageRoute());
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: widget.linearGradient,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FadeTransition(
          opacity: _animation,
          child: Stack(
            children: <Widget>[
              if (widget.imageSrc != null && widget.imageSrc!.isNotEmpty)
                Align(
                  alignment: Alignment.center,
                  child: _buildImage(),
                ),
              if (widget.text != null)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: widget.logoSize + 40),
                    child: Padding(
                      padding: widget.paddingText,
                      child: SizedBox(height: 100, child: _buildText()),
                    ),
                  ),
                ),
              if (widget.displayLoading)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: widget.paddingLoading,
                    child: const CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    // Handling only local asset images now
    return Image.asset(
      widget.imageSrc!,
      height: widget.logoSize,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Text("Error loading image");
      },
    );
  }

  Widget _buildText() {
    return AnimatedTextKit(
      animatedTexts: [widget.text!],
    );
  }

  Route _tweenAnimationPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Route _normalPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}

enum PageRouteTransition {
  Normal,
  CupertinoPageRoute,
  SlideTransition,
}
