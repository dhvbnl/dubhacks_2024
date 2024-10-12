import 'dart:math';
import 'package:dubhacks/models/still.dart';
import 'package:dubhacks/views/history/image_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatefulWidget {
  final List<Still> _stills = [];

  History({super.key}) {
    _stills.add(Still.create(
      prompt: 'Nature\'s Art',
      photo: const AssetImage('assets/fish.jpg'),
    ));
    _stills.add(Still.create(
      prompt: 'Lolsies',
      photo: const AssetImage('assets/fish.jpg'),
    ));
  }

  List<Still> get getStills => _stills;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var currentPage = 0;
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final stills = widget.getStills;

    return PlatformScaffold(
      backgroundColor: Colors.black,
      appBar: PlatformAppBar(
        title: PlatformText(
          'Your History',
          style: GoogleFonts.raleway(color: Colors.white, fontSize: 40),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: stills.length,
              itemBuilder: (context, index) =>
                  ImageOverview(still: stills[index]),
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
            ),
          ),
          _buildButtonRow(stills),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<Still> stills) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildIconButton(
            icon: Icons.share,
            onPressed: () => shareImage(stills[currentPage]),
          ),
          const SizedBox(width: 20), // Spacing between buttons
          _buildIconButton(
            icon: Icons.shuffle,
            onPressed: () {
              final randomPage = Random().nextInt(stills.length);
              _pageController.jumpToPage(randomPage);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return PlatformTextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30, // Adjust icon size as needed
        ),
      ),
    );
  }
}
