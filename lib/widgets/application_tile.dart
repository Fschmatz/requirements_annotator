import 'package:flutter/material.dart';
import 'package:requirements_annotator/pages/requirement/requirement_list.dart';

class ApplicationTile extends StatefulWidget {
  ApplicationTile({Key? key}) : super(key: key);

  @override
  _ApplicationTileState createState() => _ApplicationTileState();
}

class _ApplicationTileState extends State<ApplicationTile> {
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
                Navigator.of(context).pop();
                // _delete();
                // widget.refreshList();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => RequirementList(),
              fullscreenDialog: true,
            )),
        title: Center(child: Text('App Name X')),
      ),
    );
  }
}
