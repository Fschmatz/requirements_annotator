import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/app_details.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({Key? key}) : super(key: key);

  _launchGithub() {
    String url = AppDetails.repositoryLink;
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    Color themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
        appBar: AppBar(
          title: const Text("App Info"),
        ),
        body: ListView(children: <Widget>[
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.deepOrangeAccent,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(AppDetails.appName + " " + AppDetails.appVersion,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          const SizedBox(height: 15),
          ListTile(
            title: Text("Dev",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: themeColorApp)),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              "Application created using Flutter and the Dart language, used for testing and learning.",
            ),
          ),
          ListTile(
            title: Text("Source Code",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: themeColorApp)),
          ),
          ListTile(
            onTap: () {
              _launchGithub();
            },
            leading: const Icon(Icons.open_in_new_outlined),
            title: const Text("View on GitHub",
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue)),
          ),
          ListTile(
            title: Text("Quote",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: themeColorApp)),
          ),
          const ListTile(
            leading: Icon(Icons.messenger_outline),
            title: Text(
              "A goal without a plan is just a wish.",
            ),
          ),
          ListTile(
            title: Text("Note About Requirements",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: themeColorApp)),
          ),
          const ListTile(
            leading: Icon(Icons.note_outlined),
            title: Text(
              '''
A FUNCTIONAL REQUIREMENT expresses an action that must be performed through the system, that is, a functional requirement is “what the system MUST do“.

A NON-FUNCTIONAL requirement can be defined as “how the system should do”.
''',
            ),
          ),
          const SizedBox(height: 50,)
        ]));
  }
}
