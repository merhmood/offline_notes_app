import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offline_notes/icons/cloud_cross.dart';
import 'package:offline_notes/icons/wifi.dart';
import 'package:offline_notes/icons/cloud_done.dart';
import 'package:offline_notes/providers/notes.dart';
import 'package:offline_notes/utils/screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with WidgetsBindingObserver {
  late Future<List> _future;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _future = NotesProvider().getNotes();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _future = NotesProvider().getNotes();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(),
        actions: const [Wifi()],
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80.00,
      ),
      // The body rendering the list of notes gotten from the,
      // The SQLite database
      body: noteList(),
      // SizedBox is used for increasing the floatingAction button size.
      floatingActionButton: SizedBox(
        height: 70.0,
        width: 70.0,
        // onPressing the FloatingActionButton the user will be navigated
        // to the notes-editor screen
        child: FloatingActionButton(
          onPressed: () => context.go('/notes-editor/add'),
          elevation: 0.00,
          child: const Icon(Icons.add_rounded, size: 50.00),
        ),
      ),
    );
  }

  Widget appBarTitle() {
    // Create a padding around the appBar title, the padding on
    // the bottom is set to zero
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Row(
        children: [
          // The app logo set to a width and height of 52.0
          Image.asset(
            'assets/logo.png',
            height: 52.0,
            width: 52.0,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.00),
            child: Column(
              // The Column that contains the logo text is set to align left,
              // as oppose to default center.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Elastic Team',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 0, 122, 1), fontSize: 18.00),
                ),
                Text(
                  'Notes App',
                  style: TextStyle(color: Colors.black, fontSize: 18.00),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget noteList() {
    // This is a vertical scrollable list, with a container expanded
    // to fill all the available space
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(34.0, 0.0, 34.0, 0.0),
              // This builds the future Notes we go from the Notes Provider,
              // without the future build the notes may be null, because,
              // they not be available yet
              child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  // Checks for finished connection state.
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Check for the availability of the Notes data
                    if (snapshot.hasData) {
                      // Iterates of the Notes and displays a List tile
                      return ListView.builder(
                        // Ensures that each list increase size based on it's childs size
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsetsDirectional.only(top: 10.0),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(253, 255, 182, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )),
                            child: ListTile(
                              onTap: () {
                                // Holds the noteId value
                                final noteId = snapshot.data![index]['noteId'];
                                if (noteId != null) {
                                  // Navigates to the edit page, based on its noteId
                                  context.go(
                                    "/notes-editor/edit/$noteId",
                                  );
                                }
                              },
                              title: Text(
                                snapshot.data![index]['title'],
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              trailing: ElevatedButton(
                                // On click of the sync button, modal should show up
                                onPressed: () {
                                  _showDialog(
                                      context, snapshot.data![index]['title']);
                                },
                                style: const ButtonStyle(
                                  elevation: MaterialStatePropertyAll(0.0),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.transparent),
                                ),
                                // Shows syncStatus icon based on current syncStatus data.
                                child: snapshot.data![index]['syncStatus'] ==
                                        'Unsynced'
                                    ? const CloudCross()
                                    : const CloudDone(),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  }
                  return Container();
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  void _showDialog(BuildContext contex, noteTitle) {
    String title = noteTitle;
    String text =
        "Your local note $title has changes that conflict with the version on the server. Before syncing, we need you to decide how to resolve this.";
    String warning =
        "It's important to choose carefully to ensure you don't lose any critical information.";
    // Calls modal to pop up
    ScreenUtils.modal(
        context: context,
        text: text,
        warning: warning,
        greenButtonText: "Use Server",
        redButtonText: "Keep Local",
        redOnpressed: () {},
        greenOnpressed: () {});
  }
}
