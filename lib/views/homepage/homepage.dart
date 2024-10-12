import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String prompt = "a pop of red";
  
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'stills',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "today's prompt is...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0
                    ),
                  ),
                Text(
                    prompt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0
                    ),
                ),]
              ),
      
              SizedBox(height: 5,),
      
              PlatformIconButton(
                icon: Icon(
                  Icons.camera_alt_rounded,
                  size: 100,
                  color: Colors.white,
                )
              ),
              SizedBox(height: 60,),
          
              PlatformTextButton(
                onPressed: () {
                  print("hello");
                },
                color: Colors.white,
                child: const Text(
                  'History',
                  style: TextStyle(color: Colors.black),
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }
}