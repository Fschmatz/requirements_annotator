import 'package:flutter/material.dart';
import 'package:requirements_annotator/classes/app.dart';
import 'package:requirements_annotator/classes/requirement.dart';
import 'package:requirements_annotator/db/requirement_dao.dart';
import 'package:requirements_annotator/pages/requirement/requirement_new_edit.dart';

import '../../widgets/requirement_tile.dart';

class RequirementList extends StatefulWidget {
  //int appId;
  App app;

  RequirementList({Key? key, required this.app}) : super(key: key);

  @override
  _RequirementListState createState() => _RequirementListState();
}

class _RequirementListState extends State<RequirementList> {
  List<Map<String, dynamic>> _reqListFunc = [];
  List<Map<String, dynamic>> _reqListNotFunc = [];
  bool loading = false;

  @override
  void initState() {
    getAllByAppId();
    super.initState();
  }

  Future<void> getAllByAppId() async {
    final reqs = RequirementDao.instance;
    var respFunc = await reqs.queryAllByIdAppState(widget.app.id, 1);
    var respNotFunc = await reqs.queryAllByIdAppState(widget.app.id , 0);
    setState(() {
      _reqListFunc = respFunc;
      _reqListNotFunc = respNotFunc;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    Color themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.app.name),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.edit_outlined,
              ),
              onPressed: () {}),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              icon: const Icon(
                Icons.delete_outline,
              ),
              onPressed: () {}),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: loading
            ? const Center(child: SizedBox.shrink())
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                    ListTile(
                      title: Text('Functional',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: themeColorApp)
                      ),
                    ),
                    ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 16,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _reqListFunc.length,
                      itemBuilder: (context, index) {
                        return RequirementTile(
                          requirement: Requirement(
                            _reqListFunc[index]['id_requirement'],
                            _reqListFunc[index]['name'],
                            _reqListFunc[index]['note'],
                            _reqListFunc[index]['state'],
                            _reqListFunc[index]['id_app'],
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Non-Functional',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: themeColorApp)
                      ),
                    ),
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      height: 16,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _reqListNotFunc.length,
                    itemBuilder: (context, index) {
                      return RequirementTile(
                        requirement: Requirement(
                          _reqListNotFunc[index]['id_requirement'],
                          _reqListNotFunc[index]['name'],
                          _reqListNotFunc[index]['note'],
                          _reqListNotFunc[index]['state'],
                          _reqListNotFunc[index]['id_app'],
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
                  refreshList: getAllByAppId,
                  appId: widget.app.id,
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
