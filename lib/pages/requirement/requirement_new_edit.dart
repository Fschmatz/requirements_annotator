import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:requirements_annotator/classes/requirement.dart';
import 'package:requirements_annotator/db/requirement_dao.dart';

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
  bool _validName = true;
  bool _validNote = true;

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

  bool validateTextFields() {
    bool ok = true;
    if (controllerName.text.isEmpty) {
      _validName = false;
      ok = false;
    }
    if (controllerNote.text.isEmpty) {
      _validNote = false;
      ok = false;
    }
    return ok;
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
              if (validateTextFields()) {
                if (widget.edit) {
                  _updateRequirement();
                } else {
                  _saveRequirement();
                  widget.refreshList();
                }
                Navigator.of(context).pop();
              } else {
               setState(() {
                 _validName;
                 _validNote;
               });
              }
            },
          )
        ],
        title: const Text('New Requirement'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              autofocus: widget.edit ? false : true,
              minLines: 1,
              maxLines: 5,
              maxLength: 500,
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
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: controllerNote,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                counterText: "",
                helperText: "* Required",
                labelText: "Note",
                errorText: (_validNote) ? null : "Note is empty",
              ),
            ),
          ),
          ListTile(
            title: Text("State",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor)),
          ),
          SwitchListTile(
            activeColor: Theme.of(context).colorScheme.secondary,
            key: UniqueKey(),
            value: required,
            title: Text(required ? 'Functional' : 'Non-Functional'),
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
