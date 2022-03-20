import 'package:flutter/material.dart';
import 'package:requirements_annotator/pages/requirement/requirement_list.dart';

class RequirementTile extends StatefulWidget {
  RequirementTile({Key? key}) : super(key: key);

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
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            title: Text('Olá'),


          ),
        ));
  }
}
