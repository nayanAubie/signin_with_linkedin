import 'package:flutter/material.dart';
import 'package:signin_with_linkedin/signin_with_linkedin.dart';

import 'info_row.dart';

class UserInfoWidget extends StatelessWidget {
  final LinkedInUser user;

  const UserInfoWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'User Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (user.picture != null) ...[
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(user.picture!),
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoRow(label: 'Name', value: user.name),
                          InfoRow(label: 'Given Name', value: user.givenName),
                          InfoRow(label: 'Family Name', value: user.familyName),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                InfoRow(label: 'ID/sub', value: user.sub),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: InfoRow(
                        label: 'Email',
                        value: '${user.email} ${user.emailVerified ?? false}',
                      ),
                    ),
                    if (user.emailVerified ?? false)
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.verified, color: Colors.green),
                      ),
                  ],
                ),
                const Divider(),
                InfoRow(
                  label: 'Locale',
                  value:
                      'Country: ${user.locale?.country}, Language: ${user.locale?.language}',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
