import 'dart:io';
import 'package:dubhacks/models/still.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageOverview extends StatelessWidget {
  static const imageDescriptorSize = 25.0;

  final Still still;

  const ImageOverview({super.key, required this.still});

  @override
  Widget build(BuildContext context) {
    var date = still.getDate;
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              PlatformText(
                still.getPrompt,
                style: GoogleFonts.raleway(
                  fontSize: imageDescriptorSize,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 5),
          Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: _buildImageOrLoading(still.getPhoto),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Spacer(),
              PlatformText(
                '${date.month}/${date.day}/${date.year}',
                style: GoogleFonts.raleway(
                  fontSize: imageDescriptorSize,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildImageOrLoading(String path) {
  return FutureBuilder<Widget>(
    future: _buildImage(path),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return snapshot.data!;
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}

Future<Widget> _buildImage(String path) async {
  String imagePath = await tempPath(path);
  return Image.file(
    File(imagePath),
  );
}

Future<String> tempPath(String path) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  return "${appDocDir.path}/$path";
}

Future<void> shareImage(Still still) async {
  try {
    String path = await tempPath(still.getPhoto);
    ByteData bytes = await rootBundle.load(path);
    File tempFile = File(path);

    await tempFile.writeAsBytes(bytes.buffer.asUint8List());

    await Share.shareXFiles(
      [XFile(path)],
      text:
          "'${still.getPrompt}', ${still.getDate.month}.${still.getDate.day}.${still.getDate.year}",
    );
  } catch (e) {
    print('Error sharing image: $e');
  }
}
