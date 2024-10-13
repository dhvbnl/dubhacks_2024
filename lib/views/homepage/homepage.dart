import 'dart:io';

import 'package:dubhacks/helpers/promptManager.dart';
import 'package:dubhacks/models/still.dart';
import 'package:dubhacks/providers/still_provider.dart';
import 'package:dubhacks/views/camera.dart';
import 'package:dubhacks/views/history/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final PromptManager promptManager;

  const HomePage({super.key, required this.promptManager});

  PromptManager get getPromptManager => promptManager;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var prompt = "";
  String filepath = 'null';

  Widget build(BuildContext context) {
    prompt = widget.getPromptManager.getPrompt();

    return PlatformScaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PlatformAppBar _buildAppBar() {
    return PlatformAppBar(
      backgroundColor: Colors.black,
      title: Center(
        child: Text(
          'stills',
          style: GoogleFonts.updock(
            color: Colors.white,
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        children: [
          _buildPromptSection(),
          _buildCameraButton(),
          _buildHistoryButton(),
        ],
      ),
    );
  }

  Widget _buildPromptSection() {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "today's prompt is...",
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                color: Colors.white70,
                fontSize: 30.0,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            prompt,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              color: Colors.white,
              fontSize: 35.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraButton() {
    return Consumer<StillsProvider>(builder: (context, stillsProvider, child) {
      return Expanded(
        flex: 3,
        child: PlatformTextButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              Platform.isIOS
                  ? CupertinoPageRoute(builder: (context) => const CameraPage())
                  : MaterialPageRoute(builder: (context) => const CameraPage()),
            );
            if (result != null) {
              setState(() {
                filepath = result;
                stillsProvider.upsertStill(Still.create(
                  prompt: prompt,
                  path: filepath,
                ));
              });
              print(result);
            }
          },
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius:
                  BorderRadius.circular(25.0), // Optional: rounded corners
              border: Border.all(color: Colors.white),
            ),
            child: const Center(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHistoryButton() {
    return Consumer<StillsProvider>(
      builder: (context, stillsProvider, child) {
        return Expanded(
          child: PlatformTextButton(
            onPressed: () {
              Navigator.push(
                context,
                Platform.isIOS
                    ? CupertinoPageRoute(
                        builder: (context) =>
                            History(stills: stillsProvider.getStills),
                      )
                    : MaterialPageRoute(
                        builder: (context) =>
                            History(stills: stillsProvider.getStills),
                      ),
              );
            },
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 10.0, bottom: 40.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.circular(25.0), // Optional: rounded corners
                  border: Border.all(color: Colors.white),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Make the row take only the needed space
                  children: [
                    const Spacer(),
                    const Icon(
                      Icons.history, // You can choose any icon you like
                      color: Colors.white,
                      size: 30.0, // Adjust the size as needed
                    ),
                    const SizedBox(width: 10), // Spacing between icon and text
                    Text(
                      'History',
                      style: GoogleFonts.raleway(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                  ],
                )),
          ),
        );
      },
    );
  }
}
