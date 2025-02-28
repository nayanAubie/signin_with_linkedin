import 'package:flutter/material.dart';
import 'package:signin_with_linkedin/signin_with_linkedin.dart';

import 'info_row.dart';

class TokenInfoWidget extends StatelessWidget {
  final LinkedInTokenInfo tokenInfo;

  const TokenInfoWidget({super.key, required this.tokenInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Token Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoRow(
                  label: 'Access Token',
                  value: tokenInfo.accessToken,
                  maxLines: 1,
                ),
                const Divider(),
                InfoRow(
                  label: 'Expires In',
                  value: '${tokenInfo.expiresIn} seconds',
                ),
                const Divider(),
                InfoRow(label: 'Scope', value: tokenInfo.scope),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
