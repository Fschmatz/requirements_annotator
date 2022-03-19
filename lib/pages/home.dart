import 'package:flutter/material.dart';

import '../widgets/application_tile.dart';
import 'configs/settings_page.dart';
import 'requirement_new_edit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> repositoriesList = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Requirements Annotator'),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.add_outlined,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => RequirementNewEdit(),
                        fullscreenDialog: true,
                      ));
                }),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const SettingsPage(),
                        fullscreenDialog: true,
                      ));
                }),
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: loading
              ? const Center(child: SizedBox.shrink())
              : GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return ApplicationTile(
                      key: UniqueKey(),
                    );
                  }),
        ));
  }
}
