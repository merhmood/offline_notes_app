import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offline_notes/icons/delete.dart';
import 'package:offline_notes/icons/save.dart';
import 'package:offline_notes/providers/notes.dart';
import 'package:offline_notes/utils/screen.dart';
import 'package:offline_notes/widgets/back_button.dart';

class Edit extends StatefulWidget {
  final String? id;
  const Edit({super.key, this.id});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late Future<List> _futureData;
  bool isEditing = false;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _futureData = getFutureData();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  Future<List> getFutureData() async {
    List data = await NotesProvider().getNote(widget.id);
    _titleController = TextEditingController(text: data[0]['title']);
    _contentController = TextEditingController(text: data[0]['content']);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
                elevation: MaterialStatePropertyAll(0.0),
              ),
              onPressed: () {
                _showDialog(context);
              },
              child: const DeleteIcon(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 15.0, 35.0, 15.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  List newNote = [
                    {
                      'noteId': widget.id,
                      'title': _titleController.text,
                      'content': _contentController.text,
                    }
                  ];
                  NotesProvider().updateNote(newNote);
                  context.go('/');
                });
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                elevation: MaterialStatePropertyAll(0.0),
              ),
              child: const SaveIcon(),
            ),
          )
        ],
        backgroundColor: Colors.white,
        toolbarHeight: 85.0,
        elevation: 0,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(38.0, 20.0, 37.0, 10.0),
                          child: isEditing
                              ? TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 2,
                                  controller: _titleController,
                                  style: const TextStyle(fontSize: 30.0),
                                )
                              : SizedBox(
                                  width: double.maxFinite,
                                  child: Text(
                                    snapshot.data![0]['title'],
                                    style: const TextStyle(fontSize: 30.0),
                                  ),
                                ),
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                38.0, 20.0, 37.0, 10.0),
                            child: SingleChildScrollView(
                              child: isEditing
                                  ? TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      controller: _contentController,
                                      style: const TextStyle(fontSize: 20.0),
                                    )
                                  : Text(
                                      snapshot.data![0]['content'],
                                      style: const TextStyle(fontSize: 20.0),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
                return Container();
              },
            ),
          )),
    );
  }

  void _showDialog(BuildContext context) {
    String text = "Are your sure you want delete the note?";
    ScreenUtils.modal(
        context: context,
        text: text,
        greenButtonText: "Add",
        redButtonText: "Delete",
        redOnpressed: () {
          setState(() {
            NotesProvider().deletetNote(widget.id);
            context.go('/');
          });
        },
        greenOnpressed: () {
          setState(() {
            isEditing = true;
          });
          Navigator.pop(context);
        });
  }
}
