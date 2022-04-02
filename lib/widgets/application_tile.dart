import 'package:flutter/material.dart';
import 'package:requirements_annotator/classes/application.dart';
import 'package:requirements_annotator/pages/requirement/requirement_list.dart';

class ApplicationTile extends StatefulWidget {

  Application app;
  ApplicationTile({Key? key, required this.app}) : super(key: key);

  @override
  _ApplicationTileState createState() => _ApplicationTileState();
}

class _ApplicationTileState extends State<ApplicationTile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => RequirementList(
                app: widget.app,
              ),
              fullscreenDialog: true,
            )),
        title: Text(widget.app.name),
        subtitle: widget.app.description.isEmpty ? null : Text(widget.app.description),
      ),
    );
  }
}
