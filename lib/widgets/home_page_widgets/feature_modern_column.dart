import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:skill_factorial/widgets/cached_network_image_widget.dart';
import 'package:skill_factorial/widgets/home_page_widgets/cta_button.dart';

class FeatureModernColumn extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const FeatureModernColumn({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: CachedNetworkImageWidget(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorWidget: const Icon(Icons.broken_image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: SingleChildScrollView(
                      child: Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                          // color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  buildCtaButton(
                    text: "Learn More",
                    onPressed: () => context.go('/login'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
