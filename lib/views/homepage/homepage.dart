import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('stills'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformIconButton(
              icon: Icon(
                Icons.camera_alt_rounded,
                size: 60,
              )
            ),
            SizedBox(height: 60,),
        
            PlatformTextButton(
              onPressed: () {},
              color: Colors.black,
              child: const Text('History'),
              
            )
        
          ],
        ),
      ),
    );
  }
}