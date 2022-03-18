import 'dart:convert';
import 'package:flutter/material.dart';
import '../util/utils_functions.dart';

class RepositoryTile extends StatefulWidget {


  RepositoryTile(
      {Key? key})
      : super(key: key);

  @override
  _RepositoryTileState createState() => _RepositoryTileState();
}

class _RepositoryTileState extends State<RepositoryTile> {


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
    final Brightness _tagTextBrightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 50,
        child: Card(
          child: Center(child: Text('oi')),
        ),
      ),
    );
  }
}
