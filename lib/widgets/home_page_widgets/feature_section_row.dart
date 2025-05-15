import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_factorial/screens/register.dart';
import 'package:skill_factorial/widgets/cached_network_image_widget.dart';
import 'package:skill_factorial/widgets/home_page_widgets/cta_button.dart';

class FeatureSectionRow extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String type;

  const FeatureSectionRow({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            return Column(
              children: [
                _buildMobileImage(),
                const SizedBox(height: 10),
                _buildContent(context),
              ],
            );
          }
          return Row(
            children: [
              if (type == "Image") _buildDesktopImage(),
              Expanded(child: _buildContent(context)),
              if (type == "Text") _buildDesktopImage(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDesktopImage() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImageWidget(
            imageUrl: imageUrl,
            height: 400,
            fit: BoxFit.cover,
            errorWidget: const Icon(Icons.broken_image),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileImage() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImageWidget(
          imageUrl: imageUrl,
          height: 400,
          fit: BoxFit.cover,
          errorWidget: const Icon(Icons.broken_image),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(
              fontSize: 18,
              // color: Colors.grey.shade700,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          buildCtaButton(
            text: "Learn More",
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
    );
  }
}
