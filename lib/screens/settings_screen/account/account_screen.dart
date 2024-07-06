import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gyawun_beta/services/yt_account.dart';
import 'package:gyawun_beta/themes/text_styles.dart';
import '../color_icon.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Account',
            style: mediumTextStyle(context, bold: false)),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: ValueListenableBuilder(
              valueListenable: GetIt.I<YTAccount>().user,
              builder: (context, user, child) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        tileColor: Colors.grey.withAlpha(30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        title: Text(
                          user != null ? user.name : 'Log In',
                          style: textStyle(context, bold: false)
                              .copyWith(fontSize: 16),
                        ),
                        leading: user != null
                            ? CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  user.photos.first['url'],
                                ),
                              )
                            : const ColorIcon(
                                color: null,
                                icon: Icons.login,
                              ),
                        trailing: user != null
                            ? FilledButton(
                                onPressed: () async {
                                  await GetIt.I<YTAccount>().logOut(context);
                                },
                                child: const Text('Log Out'),
                              )
                            : null,
                        onTap: () async {
                          if (user == null) {
                            await GetIt.I<YTAccount>().login(context);
                          }
                        },
                        subtitle:
                            user != null ? Text(user.channelHandle) : null,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}


        // onTap: (context) async {
        //   // await GetIt.I<YTMusic>().toggleLogin(context);
        //   // await GetIt.I<YTMusic>().refreshHeaders();
        // },
        // trailing: (context) =>
        //  ValueListenableBuilder(
        //   valueListenable: GetIt.I<YTMusic>().isLogged,
        //   builder: (context, value, child) {
        //     return Text(value ? 'Logged' : 'Not Logged');
        //   },
        // ),