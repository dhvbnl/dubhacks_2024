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
      padding: const EdgeInsets.all(20.0),
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
          const SizedBox(height: 10),
          Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(image: AssetImage(still.getPhoto)),
            ),
          ),
          const SizedBox(height: 10),
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

Future<void> shareImage(Still still) async {
  try {
    ByteData bytes = await rootBundle.load(still.getPhoto);
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = '${tempDir.path}/image.jpg';

    File tempFile = File(tempPath);
    await tempFile.writeAsBytes(bytes.buffer.asUint8List());

    await Share.shareXFiles(
      [XFile(tempPath)],
      text:
          "'${still.getPrompt}', ${still.getDate.month}.${still.getDate.day}.${still.getDate.year}",
    );
  } catch (e) {
    print('Error sharing image: $e');
  }
}
