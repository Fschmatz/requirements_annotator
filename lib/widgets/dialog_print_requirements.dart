import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogPrintRequirements extends StatefulWidget {

  List<Map<String, dynamic>> funcReq;
  List<Map<String, dynamic>> nonFuncReq;

  DialogPrintRequirements({Key? key, required this.funcReq, required this.nonFuncReq}) : super(key: key);

  @override
  _DialogPrintRequirementsState createState() => _DialogPrintRequirementsState();
}

class _DialogPrintRequirementsState extends State<DialogPrintRequirements> {

  String formattedList = '';

  @override
  void initState() {
    formatList();
    super.initState();
  }

  void formatList() async {
    formattedList += 'Functional\n';
    for (int i = 0; i < widget.funcReq.length; i++) {
      formattedList += "• " +  widget.funcReq[i]['name'].toString() + "\n";
    }

    formattedList += '\nNon-Functional\n';
    for (int i = 0; i < widget.nonFuncReq.length; i++) {
      formattedList += "• " +  widget.nonFuncReq[i]['name'].toString() + "\n";
    }
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
      title: const Text('Requirements'),
      scrollable: true,
      content: SizedBox(
          height: 250.0,
          width: 350.0,
          child: SelectableText(formattedList)),
      actions: [
        TextButton(
          child: const Text(
            "Close",
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            "Copy list",
          ),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: formattedList));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
