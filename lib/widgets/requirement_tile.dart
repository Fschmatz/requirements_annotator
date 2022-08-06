import 'package:flutter/material.dart';
import 'package:requirements_annotator/classes/requirement.dart';
import 'package:requirements_annotator/db/requirement_dao.dart';

import '../pages/requirement/requirement_new_edit.dart';

class RequirementTile extends StatefulWidget {

  Requirement requirement;
  Function() refreshRequirementList;

  RequirementTile({Key? key, required this.requirement, required this.refreshRequirementList}) : super(key: key);

  @override
  _RequirementTileState createState() => _RequirementTileState();
}

class _RequirementTileState extends State<RequirementTile> {

  @override
  void initState() {
    super.initState();
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
                widget.refreshRequirementList();
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
    final deleted = await reqs.delete(widget.requirement.id);
  }

  void openBottomMenu() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text(
                      "Edit",
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => RequirementNewEdit(
                              edit: true,
                              appId: widget.requirement.appId,
                              requirement: widget.requirement,
                              refreshList: initState,
                            ),
                          ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete_outline_outlined),
                    title: const Text(
                      "Delete",
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      showAlertDialogOkDelete(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: openBottomMenu,
      title: Text(widget.requirement.name),
      subtitle: widget.requirement.note.isEmpty ? null : Text(widget.requirement.note),
    );
  }
}
