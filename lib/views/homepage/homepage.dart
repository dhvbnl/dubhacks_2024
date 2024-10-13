import 'package:dubhacks/models/still.dart';
import 'package:dubhacks/providers/still_provider.dart';
import 'package:dubhacks/views/camera.dart';
import 'package:dubhacks/views/history/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String prompt = "a pop of red";
  String filepath = 'null';

  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PlatformAppBar _buildAppBar() {
    return PlatformAppBar(
      backgroundColor: Colors.black,
      title: Text(
        'stills',
        style: GoogleFonts.updock(
          color: Colors.white,
          fontSize: 40.0,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPromptSection(),
          const Spacer(),
          _buildCameraButton(),
          const Spacer(),
          _buildHistoryButton(),
          const SizedBox(height: 100)
        ],
      ),
    );
  }

  Widget _buildPromptSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            "today's prompt is...",
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
        ),
        Text(
          prompt,
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
      ],
    );
  }

  Widget _buildCameraButton() {
    return Consumer<StillsProvider>(builder: (context, stillsProvider, child) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Colors.white, width: 1.0),
        ),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(110.0),
          child: PlatformIconButton(
            icon: const Icon(
              Icons.add_circle,
              size: 100,
              color: Colors.white,
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraPage()),
              );
              if (result != null) {
                setState(() {
                  filepath = result;
                });
                print(result);
              }
              stillsProvider.upsertStill(
                Still.create(prompt: prompt, path: filepath),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildHistoryButton() {
    return PlatformTextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => History(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisSize:
                MainAxisSize.min, // Make the row take only the needed space
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
