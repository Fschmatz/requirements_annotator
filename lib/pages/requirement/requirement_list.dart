import 'package:flutter/material.dart';
import 'package:requirements_annotator/classes/requirement.dart';
import 'package:requirements_annotator/db/requirement_dao.dart';
import 'package:requirements_annotator/pages/requirement/requirement_new_edit.dart';
import '../../widgets/requirement_tile.dart';

class RequirementList extends StatefulWidget {

  int appId;

  RequirementList({Key? key,required this.appId}) : super(key: key);

  @override
  _RequirementListState createState() => _RequirementListState();
}

class _RequirementListState extends State<RequirementList> {
  List<Map<String, dynamic>> _reqList = [];
  bool loading = false;

  @override
  void initState() {
    getAllByAppId();
    super.initState();
  }

  Future<void> getAllByAppId() async {
    final reqs = RequirementDao.instance;
    var resp = await reqs.queryAllRows();
    setState(() {
      _reqList = resp;
      loading = false;
    });
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
                      itemCount: _reqList.length,
                      itemBuilder: (context, index) {
                        return RequirementTile(
                          requirement: Requirement(
                            _reqList[index]['id'],
                            _reqList[index]['name'],
                            _reqList[index]['state'],
                            _reqList[index]['appId'],
                          ),
                        );
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
                builder: (BuildContext context) => RequirementNewEdit(
                  appId: widget.appId,
                ),
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
