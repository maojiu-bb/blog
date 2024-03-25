import 'package:blog/index.dart';
import 'package:flutter/material.dart';

class BlogItemWidget extends StatelessWidget {
  final String cover;

  final String title;

  final String text;

  final String date;

  const BlogItemWidget({
    super.key,
    required this.cover,
    required this.title,
    required this.text,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 50),
      child: SizedBox(
        width: 800,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                cover,
                width: 800,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 22,
                  // fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              date,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
