import 'package:flutter/cupertino.dart';

import 'dash_border.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 120, // Adjust as needed
        height: 120, // Adjust as needed
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding:
                    const EdgeInsets.all(4.0), // Adjust the padding as needed
                child: ClipOval(
                  child: Image.asset(
                    "images/user.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            CustomPaint(
              size: const Size(120, 120),
              painter: DashedBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
