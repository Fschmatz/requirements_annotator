import 'package:flutter/material.dart';
import 'package:requirements_annotator/pages/requirement/requirement_new_edit.dart';
import '../../widgets/requirement_tile.dart';


class RequirementList extends StatefulWidget {
  const RequirementList({Key? key}) : super(key: key);

  @override
  _RequirementListState createState() => _RequirementListState();
}

class _RequirementListState extends State<RequirementList> {
  List<Map<String, dynamic>> repositoriesList = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Name'),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.edit_outlined,
              ),
              onPressed: () {

              }),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              icon: const Icon(
                Icons.delete_outline,
              ),
              onPressed: () {

              }),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: loading
            ? const Center(child: SizedBox.shrink())
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                    ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 16,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return RequirementTile();
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ]),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => RequirementNewEdit(),
                fullscreenDialog: true,
              ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
      ),
    );
  }
}
