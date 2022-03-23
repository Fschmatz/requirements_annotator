import 'package:flutter/material.dart';
import 'package:requirements_annotator/db/app_dao.dart';
import 'package:requirements_annotator/classes/app.dart';
import '../../widgets/application_tile.dart';

class AppList extends StatefulWidget {
  const AppList({Key? key}) : super(key: key);

  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  List<Map<String, dynamic>> _appsList = [];
  bool loading = true;

  @override
  void initState() {
    getAll();
    super.initState();
  }

  Future<void> getAll() async {
    final tasks = AppDao.instance;
    var resp = await tasks.queryAllRowsByName();
    setState(() {
      _appsList = resp;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(
              height: 16,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _appsList.length,
            itemBuilder: (context, index) {
              return ApplicationTile(
                app: App(
                  _appsList[index]['id_app'],
                  _appsList[index]['name'],
                  _appsList[index]['description'],
                )
              );
            },
          ),
          const SizedBox(
            height: 50,
          )
        ]);
  }
}
