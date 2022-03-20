import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/dialog_alert_error.dart';

class RequirementNewEdit extends StatefulWidget {
  @override
  _RequirementNewEditState createState() => _RequirementNewEditState();

  RequirementNewEdit({Key? key}) : super(key: key);
}

class _RequirementNewEditState extends State<RequirementNewEdit> {
  TextEditingController controllerName = TextEditingController();
  bool required = false;

  String checkForErrors() {
    String errors = "";
    if (controllerName.text.isEmpty) {
      errors += "Name is empty\n";
    }
    return errors;
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
                //getRepositoryDataAndSave();
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
        title: const Text('New Requirement'),
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
              maxLength: 500,
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
            title: Text("State",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary)),
          ),
          CheckboxListTile(
            activeColor: Theme.of(context).colorScheme.secondary,
            key: UniqueKey(),
            value: required,
            title: const Text('Required'),
            onChanged: (v) {
              setState(() {
                required = !required;
              });
              print(required);
            },
          ),
        ],
      ),
    );
  }
}
