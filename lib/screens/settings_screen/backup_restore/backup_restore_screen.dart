import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../themes/text_styles.dart';
import '../color_icon.dart';
import 'backup_restore_screen_data.dart';

class BackupRestoreScreen extends StatelessWidget {
  const BackupRestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back up and Restore',
            style: mediumTextStyle(context, bold: false)),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              ...backupRestoreScreenData(context).map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    tileColor: Colors.grey.withAlpha(30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    title: Text(
                      e.title,
                      style: textStyle(context, bold: false)
                          .copyWith(fontSize: 16),
                    ),
                    leading: (e.icon != null)
                        ? ColorIcon(
                            color: e.color,
                            icon: e.icon!,
                          )
                        : null,
                    trailing: e.trailing != null
                        ? e.trailing!(context)
                        : (e.hasNavigation
                            ? const Icon(
                                CupertinoIcons.chevron_right,
                                size: 30,
                              )
                            : null),
                    onTap: () {
                      if (e.hasNavigation && e.location != null) {
                        context.go(e.location!);
                      } else if (e.onTap != null) {
                        e.onTap!(context);
                      }
                    },
                    subtitle: e.subtitle != null ? e.subtitle!(context) : null,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
