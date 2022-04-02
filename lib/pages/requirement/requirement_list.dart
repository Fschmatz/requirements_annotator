import 'package:flutter/material.dart';
import 'package:requirements_annotator/classes/application.dart';
import 'package:requirements_annotator/classes/requirement.dart';
import 'package:requirements_annotator/db/application_dao.dart';
import 'package:requirements_annotator/db/requirement_dao.dart';
import 'package:requirements_annotator/pages/requirement/requirement_new_edit.dart';
import '../../widgets/requirement_tile.dart';
import '../app/application_new_edit.dart';

class RequirementList extends StatefulWidget {
  Application app;

  RequirementList({Key? key, required this.app}) : super(key: key);

  @override
  _RequirementListState createState() => _RequirementListState();
}

class _RequirementListState extends State<RequirementList> {
  List<Map<String, dynamic>> _reqListFunc = [];
  List<Map<String, dynamic>> _reqListNotFunc = [];
  bool loading = false;

  @override
  void initState() {
    getAllByAppId();
    super.initState();
  }

  Future<void> getAllByAppId() async {
    final reqs = RequirementDao.instance;
    var respFunc = await reqs.queryAllByIdAppState(widget.app.id, 1);
    var respNotFunc = await reqs.queryAllByIdAppState(widget.app.id, 0);
    setState(() {
      _reqListFunc = respFunc;
      _reqListNotFunc = respNotFunc;
      loading = false;
    });
  }

  showAlertDialogOkDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm",
          ),
          content: const Text(
            "Delete ?",
          ),
          actions: [
            TextButton(
              child: const Text(
                "Yes",
              ),
              onPressed: () {
                _delete();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _delete() async {
    final apps = ApplicationDao.instance;
    final deleted = await apps.delete(widget.app.id);
  }

  @override
  Widget build(BuildContext context) {
    Color themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.app.name),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.edit_outlined,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => ApplicationNewEdit(
                        edit: true,
                        application:  widget.app,
                      ),
                      fullscreenDialog: true,
                    ));
              }),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              icon: const Icon(
                Icons.delete_outline,
              ),
              onPressed: () {
                showAlertDialogOkDelete(context);
              }),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: loading
            ? const Center(child: SizedBox.shrink())
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                    ListTile(
                      title: Text('Functional',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: themeColorApp)),
                    ),
                    _reqListFunc.isEmpty
                        ? const ListTile(
                            title: Text('Shall we begin?'),
                          )
                        : ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 0,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _reqListFunc.length,
                            itemBuilder: (context, index) {
                              return RequirementTile(
                                requirement: Requirement(
                                  _reqListFunc[index]['id_requirement'],
                                  _reqListFunc[index]['name'],
                                  _reqListFunc[index]['note'],
                                  _reqListFunc[index]['state'],
                                  _reqListFunc[index]['id_app'],
                                ),
                              );
                            },
                          ),
                    ListTile(
                      title: Text('Non-Functional',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: themeColorApp)),
                    ),
                    _reqListNotFunc.isEmpty
                        ? const ListTile(
                            title: Text('There must be something to put in here...'),
                          )
                        : ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 0,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _reqListNotFunc.length,
                            itemBuilder: (context, index) {
                              return RequirementTile(
                                requirement: Requirement(
                                  _reqListNotFunc[index]['id_requirement'],
                                  _reqListNotFunc[index]['name'],
                                  _reqListNotFunc[index]['note'],
                                  _reqListNotFunc[index]['state'],
                                  _reqListNotFunc[index]['id_app'],
                                ),
                              );
                            },
                          ),
                    const SizedBox(
                      height: 50,
                    )
                  ]),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => RequirementNewEdit(
                  refreshList: getAllByAppId,
                  appId: widget.app.id,
                  edit: false,
                ),
                fullscreenDialog: true,
              ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
      ),
    );
  }
}
