import 'package:flutter/material.dart';
import 'package:requirements_annotator/classes/app.dart';
import 'package:requirements_annotator/pages/requirement/requirement_list.dart';

class ApplicationTile extends StatefulWidget {

  App app;
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
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => RequirementList(
                appId: widget.app.id,
              ),
              fullscreenDialog: true,
            )),
        title: Text(widget.app.name),
        subtitle: Text(widget.app.description),
      ),
    );
  }
}
