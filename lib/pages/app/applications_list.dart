import 'package:flutter/material.dart';
import 'package:requirements_annotator/classes/application.dart';
import '../../widgets/application_tile.dart';

class ApplicationsList extends StatefulWidget {

  List<Map<String, dynamic>> appsList;
  Function() refreshHome;

  ApplicationsList({Key? key,required this.appsList, required this.refreshHome}) : super(key: key);

  @override
  _ApplicationsListState createState() => _ApplicationsListState();
}

class _ApplicationsListState extends State<ApplicationsList> {

  @override
  Widget build(BuildContext context) {
    return  ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.appsList.length,
            itemBuilder: (context, index) {
              return ApplicationTile(
                refreshHome: widget.refreshHome,
                app: Application(
                  widget.appsList[index]['id_application'],
                  widget.appsList[index]['name'],
                  widget.appsList[index]['description'],
                )
              );
            },
          ),
          const SizedBox(
            height: 50,
          )
        ]);
  }
}
