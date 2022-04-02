import 'package:flutter/material.dart';
import 'package:requirements_annotator/classes/requirement.dart';

import '../pages/requirement/requirement_new_edit.dart';

class RequirementTile extends StatefulWidget {

  Requirement requirement;

  RequirementTile({Key? key, required this.requirement}) : super(key: key);

  @override
  _RequirementTileState createState() => _RequirementTileState();
}

class _RequirementTileState extends State<RequirementTile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => RequirementNewEdit(
              edit: true,
              appId: widget.requirement.appId,
              requirement: widget.requirement,
              refreshList: initState,
            ),
            fullscreenDialog: true,
          )),
      title: Text(widget.requirement.name),
      subtitle: widget.requirement.note.isEmpty ? null : Text(widget.requirement.note),
    );
  }
}
