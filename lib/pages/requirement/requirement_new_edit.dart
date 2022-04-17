import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:requirements_annotator/classes/requirement.dart';
import 'package:requirements_annotator/db/requirement_dao.dart';
import '../../widgets/dialog_alert_error.dart';

class RequirementNewEdit extends StatefulWidget {
  Function() refreshList;
  int appId;
  bool edit;
  Requirement? requirement;
  bool? functional;

  @override
  _RequirementNewEditState createState() => _RequirementNewEditState();

  RequirementNewEdit(
      {Key? key,
      this.requirement,
      required this.appId,
      required this.refreshList,
      this.functional,
      required this.edit})
      : super(key: key);
}

class _RequirementNewEditState extends State<RequirementNewEdit> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  bool required = false;
  final reqs = RequirementDao.instance;

  @override
  void initState() {
    if (!widget.edit) {
      required = widget.functional!;
    }
    if (widget.edit) {
      controllerName.text = widget.requirement!.name;
      controllerNote.text = widget.requirement!.note;
      if (widget.requirement!.state == 1) {
        required = true;
      }
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

  Future<void> _saveRequirement() async {
    Map<String, dynamic> row = {
      RequirementDao.columnName: controllerName.text,
      RequirementDao.columnNote: controllerNote.text,
      RequirementDao.columnState: required == true ? 1 : 0,
      RequirementDao.columnAppId: widget.appId,
    };
    final idTask = await reqs.insert(row);
  }

  void _updateRequirement() async {
    Map<String, dynamic> row = {
      RequirementDao.columnId: widget.requirement!.id,
      RequirementDao.columnName: controllerName.text,
      RequirementDao.columnNote: controllerNote.text,
      RequirementDao.columnState: required == true ? 1 : 0,
      RequirementDao.columnAppId: widget.requirement!.appId,
    };
    final update = await reqs.update(row);
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
                  _updateRequirement();
                } else {
                  _saveRequirement();
                  widget.refreshList();
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child : TextField(
              autofocus: widget.edit ? false : true,
              minLines: 1,
              maxLines: 5,
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
            title: Text("Note",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child : TextField(
              autofocus: false,
              minLines: 1,
              maxLines: 5,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: controllerNote,
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
                    color: Theme.of(context).colorScheme.secondary
                )),
          ),
          SwitchListTile(
            activeColor: Theme.of(context).colorScheme.secondary,
            key: UniqueKey(),
            value: required,
            title: const Text('Functional'),
            onChanged: (v) {
              setState(() {
                required = !required;
              });
            },
          ),
        ],
      ),
    );
  }
}
