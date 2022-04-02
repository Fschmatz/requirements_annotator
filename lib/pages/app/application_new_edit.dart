import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:requirements_annotator/classes/application.dart';
import 'package:requirements_annotator/db/application_dao.dart';
import '../../widgets/dialog_alert_error.dart';

class ApplicationNewEdit extends StatefulWidget {

  bool edit;
  Application? application;

  @override
  _ApplicationNewEditState createState() => _ApplicationNewEditState();

  ApplicationNewEdit({Key? key, required this.edit, this.application}) : super(key: key);
}

class _ApplicationNewEditState extends State<ApplicationNewEdit> {

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  final apps = ApplicationDao.instance;

  @override
  void initState() {
    if(widget.edit){
      controllerName.text = widget.application!.name;
      controllerDescription.text = widget.application!.description;
    }
    super.initState();
  }

  String checkForErrors() {
    String errors = "";
    if (controllerName.text.isEmpty) {
      errors += "Name is empty\n";
    }
    return errors;
  }

  Future<void> _saveApp() async {
    Map<String, dynamic> row = {
      ApplicationDao.columnName: controllerName.text,
      ApplicationDao.columnDescription: controllerDescription.text,
    };
    final idTask = await apps.insert(row);
  }

  void _updateApp() async {
    Map<String, dynamic> row = {
      ApplicationDao.columnIdApplication: widget.application!.id,
      ApplicationDao.columnName: controllerName.text,
      ApplicationDao.columnDescription: controllerDescription.text,
    };
    final update = await apps.update(row);
  }

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
                  if (widget.edit) {
                    _updateApp();
                  } else {
                    _saveApp();
                  }
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
        title: const Text('New Application'),
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
              autofocus: widget.edit ? false : true,
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
