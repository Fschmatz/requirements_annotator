import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:requirements_annotator/classes/application.dart';
import 'package:requirements_annotator/db/application_dao.dart';

class ApplicationNewEdit extends StatefulWidget {
  bool edit;
  Application? application;

  @override
  _ApplicationNewEditState createState() => _ApplicationNewEditState();

  ApplicationNewEdit({Key? key, required this.edit, this.application})
      : super(key: key);
}

class _ApplicationNewEditState extends State<ApplicationNewEdit> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  final apps = ApplicationDao.instance;
  bool _validName = true;

  @override
  void initState() {
    if (widget.edit) {
      controllerName.text = widget.application!.name;
      controllerDescription.text = widget.application!.description;
    }
    super.initState();
  }

  bool validateTextFields() {
    if (controllerName.text.isEmpty) {
      _validName = false;
      return false;
    }
    return true;
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
              if (validateTextFields()) {
                if (widget.edit) {
                  _updateApp();
                } else {
                  _saveApp();
                }
                Navigator.of(context).pop();
              } else {
               setState(() {
                 _validName;
               });
              }
            },
          )
        ],
        title: const Text('New Application'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              autofocus: widget.edit ? false : true,
              minLines: 1,
              maxLines: 5,
              maxLength: 150,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: controllerName,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: "Name",
                counterText: "",
                helperText: "* Required",
                errorText: (_validName) ? null : "Name is empty",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              autofocus: false,
              minLines: 1,
              maxLines: 5,
              maxLength: 1000,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: controllerDescription,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                counterText: "",
                labelText: "Description",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
