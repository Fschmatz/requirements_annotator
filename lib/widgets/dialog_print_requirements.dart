import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogPrintRequirements extends StatefulWidget {
  List<Map<String, dynamic>> funcReq;
  List<Map<String, dynamic>> nonFuncReq;

  DialogPrintRequirements(
      {Key? key, required this.funcReq, required this.nonFuncReq})
      : super(key: key);

  @override
  _DialogPrintRequirementsState createState() =>
      _DialogPrintRequirementsState();
}

class _DialogPrintRequirementsState extends State<DialogPrintRequirements> {
  bool loading = true;
  String formattedList = '';

  @override
  void initState() {
    formatList();
    super.initState();
  }

  void formatList() async {
    formattedList += 'Functional\n';
    for (int i = 0; i < widget.funcReq.length; i++) {
      formattedList += "• " + widget.funcReq[i]['name'].toString() + "\n";
    }

    formattedList += '\nNon-Functional\n';
    for (int i = 0; i < widget.nonFuncReq.length; i++) {
      formattedList += "• " + widget.nonFuncReq[i]['name'].toString() + "\n";
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print'),
        actions: [
          TextButton(
            child: const Text(
              "Copy",
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: formattedList));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        children: [
          (loading)
              ? const SizedBox.shrink()
              : SelectableText(
                  formattedList,
                  style: const TextStyle(fontSize: 16),
                ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
