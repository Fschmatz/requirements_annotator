import 'package:flutter/material.dart';
import 'package:requirements_annotator/pages/requirement/requirement_new_edit.dart';
import '../db/application_dao.dart';
import 'app/applications_list.dart';
import 'app/application_new_edit.dart';
import 'configs/settings_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _appsList = [];
  bool loading = true;

  @override
  void initState() {
    getAllApplications();
    super.initState();
  }

  Future<void> getAllApplications() async {
    final tasks = ApplicationDao.instance;
    var resp = await tasks.queryAllRowsByName();
    setState(() {
      _appsList = resp;
      loading = false;
    });
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
                        builder: (BuildContext context) => ApplicationNewEdit(
                          edit: false,
                        ),
                        fullscreenDialog: true,
                      )).then((value) => getAllApplications());
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
              : ApplicationsList(
            appsList: _appsList,
          )
        ));
  }
}
