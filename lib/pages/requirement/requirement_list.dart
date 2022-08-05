import 'package:flutter/material.dart';
import 'package:requirements_annotator/classes/application.dart';
import 'package:requirements_annotator/classes/requirement.dart';
import 'package:requirements_annotator/db/application_dao.dart';
import 'package:requirements_annotator/db/requirement_dao.dart';
import 'package:requirements_annotator/pages/requirement/requirement_new_edit.dart';
import 'package:requirements_annotator/widgets/dialog_print_requirements.dart';
import '../../util/utils_functions.dart';
import '../../widgets/requirement_tile.dart';
import '../app/application_new_edit.dart';

class RequirementList extends StatefulWidget {
  Application app;
  Function() refreshHome;

  RequirementList({Key? key, required this.app, required this.refreshHome})
      : super(key: key);

  @override
  _RequirementListState createState() => _RequirementListState();
}

class _RequirementListState extends State<RequirementList> {
  List<Map<String, dynamic>> _reqListFunc = [];
  List<Map<String, dynamic>> _reqListNotFunc = [];
  bool loading = false;

  @override
  void initState() {
    getAllRequirementsByAppId();
    super.initState();
  }

  Future<void> getAllRequirementsByAppId() async {
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
                widget.refreshHome();
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
    final reqs = RequirementDao.instance;
    final apps = ApplicationDao.instance;
    final deleted = await apps.delete(widget.app.id);
    final deleteReqs = await reqs.deleteAllFromApplicantion(widget.app.id);
  }

  @override
  Widget build(BuildContext context) {
    final Brightness _listNameTextBrightness = Theme.of(context).brightness;
    Color themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.app.name),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(useMaterial3: false),
            child: PopupMenuButton<int>(
                icon: const Icon(Icons.more_vert_outlined),
                itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                      const PopupMenuItem<int>(value: 0, child: Text('Edit')),
                      const PopupMenuItem<int>(value: 1, child: Text('Delete')),
                      const PopupMenuItem<int>(value: 2, child: Text('Print')),
                    ],
                onSelected: (int value) {
                  if (value == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ApplicationNewEdit(
                            edit: true,
                            application: widget.app,
                          ),
                        )).then((value) => widget.refreshHome());
                  } else if (value == 1) {
                    showAlertDialogOkDelete(context);
                  } else if (value == 2) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogPrintRequirements(
                            funcReq: _reqListFunc,
                            nonFuncReq: _reqListNotFunc,
                          );
                        });
                  }
                }),
          )
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
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      tileColor: themeColorApp.withOpacity(0.15),
                      title: Text('Functional',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _listNameTextBrightness == Brightness.dark
                                ? lightenColor(themeColorApp, 20)
                                : darkenColor(themeColorApp, 20),
                          )),

                    ),
                    _reqListFunc.isEmpty
                        ? ListTile(
                            title: Text(
                            'Shall we begin?',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color),
                          ))
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
                                refreshRequirementList:
                                    getAllRequirementsByAppId,
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
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      tileColor: themeColorApp.withOpacity(0.15),
                      title: Text('Non-Functional',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            color: _listNameTextBrightness == Brightness.dark
                                ? lightenColor(themeColorApp, 20)
                                : darkenColor(themeColorApp, 20),
                          )),
                    ),
                    _reqListNotFunc.isEmpty
                        ? ListTile(
                            title: Text(
                              'There must be something to put in here...',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color),
                            ),
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
                                refreshRequirementList:
                                    getAllRequirementsByAppId,
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
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    RequirementNewEdit(
                      refreshList: getAllRequirementsByAppId,
                      appId: widget.app.id,
                      edit: false,
                      functional: true,
                    ),
              ));
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary
        ),
      ),
    );
  }
}
