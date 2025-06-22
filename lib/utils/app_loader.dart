
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoader extends StatefulWidget {
  final double contHeight;
  final double contWidth;
  final String? loader;
  final Color? color;

  AppLoader({
    Key? key,
    this.loader,
    this.color,
    this.contHeight = 0,
    this.contWidth = 0,
  }) : super(key: key);

  @override
  _AppLoaderState createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,//Colors.white.withOpacity(0.1),
      body: Center(
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(
            begin: textClr, // Dark Brown for start
            end: Colors.white, // White for end
          ),
          duration: Duration(seconds: 1),
          onEnd: () {
            setState(() {
              _controller.reverse();
            });
          },
          builder: (context, color, child) {
            return LoadingAnimationWidget.fourRotatingDots(
              color: textClr, // Default to brown if color is null
              size: 100, // Increased the size for better visibility
            );
          },
        ),
      ),
    );
  }
}