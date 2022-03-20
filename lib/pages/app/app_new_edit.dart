import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:requirements_annotator/db/app_dao.dart';
import '../../widgets/dialog_alert_error.dart';

class AppNewEdit extends StatefulWidget {

  @override
  _AppNewEditState createState() => _AppNewEditState();

  AppNewEdit({Key? key}) : super(key: key);
}

class _AppNewEditState extends State<AppNewEdit> {

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  final apps = AppDao.instance;

  String checkForErrors() {
    String errors = "";
    if (controllerName.text.isEmpty) {
      errors += "Name is empty\n";
    }
    return errors;
  }

  Future<void> _saveApp() async {
    Map<String, dynamic> row = {
      AppDao.columnName: controllerName.text,
      AppDao.columnDescription: controllerDescription.text,
    };
    final idTask = await apps.insert(row);
  }

  /*Future<void> _updateTask() async {
    Map<String, dynamic> row = {
      TaskDao.columnId: widget.task.id,
      TaskDao.columnTitle: customControllerTitle.text,
      TaskDao.columnNote: customControllerNote.text,
    };
    final update = await tasks.update(row);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Save',
            icon: const Icon(
              Icons.save_outlined,
            ),
            onPressed: () async {
              String errors = checkForErrors();
              if (errors.isEmpty) {
                _saveApp();
                Navigator.of(context).pop();
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return dialogAlertErrors(errors, context);
                  },
                );
              }
            },
          )
        ],
        title: const Text('New App'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Name",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary)),
          ),
          ListTile(
            title: TextField(
              autofocus: true,
              minLines: 1,
              maxLength: 150,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: controllerName,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: "",
                helperText: "* Required",
                prefixIcon: Icon(
                  Icons.notes_outlined,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text("Description",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary)),
          ),
          ListTile(
            title: TextField(
              autofocus: true,
              minLines: 1,
              maxLength: 1000,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: controllerDescription,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: "",
                prefixIcon: Icon(
                  Icons.notes_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
