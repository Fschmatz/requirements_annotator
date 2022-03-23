import 'package:flutter/material.dart';
import 'package:requirements_annotator/classes/requirement.dart';

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
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ListTile(
        title: Text(widget.requirement.name),
        subtitle: widget.requirement.note.isEmpty ? null : Text(widget.requirement.note),
      ),
    );
  }
}
