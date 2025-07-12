import 'package:flutter/material.dart';

class ProfileCenter extends StatelessWidget {
  const ProfileCenter({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Container(
        width: double.infinity,
        height: 550,
        // padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, // или .background
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 16),
                CircleAvatar(
                  radius: 140,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/57171345?v=4',
                  ),
                ),
                SizedBox(width: 30),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 72,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    children: [
                      TextSpan(text: 'Hello, '),
                      TextSpan(
                        text: 'John',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoLine('ID:', '29489230859328502', context),
                _infoLine('Email:', 'Cockroach@mail.ru', context),
                _infoLine('Registration date:', '12.12.25', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoLine(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label $value',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
