import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offline_notes/icons/save.dart';
import 'package:offline_notes/providers/notes.dart';
import 'package:offline_notes/widgets/back_button.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  late TextEditingController _title;
  late TextEditingController _content;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _content = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _title.dispose();
    _content.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CustomBackButton(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 18.0, 22.0, 18.0),
            child: ElevatedButton(
              onPressed: () {
                if (_title.text != "" && _content.text != "") {
                  setState(() {
                    NotesProvider().addNotes(
                      _title.text,
                      _content.text,
                    );
                    context.go('/');
                  });
                }
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
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 0.0, 15.0, 0.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                style: const TextStyle(fontSize: 30.0),
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  hintStyle:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                ),
                controller: _title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 0.0, 15.0, 0.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                style: const TextStyle(fontSize: 20.0),
                decoration: const InputDecoration(
                  hintText: 'Type something...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 20.0),
                ),
                controller: _content,
              ),
            )
          ],
        ),
      ),
    );
  }
}
