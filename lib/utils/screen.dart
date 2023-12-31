import 'package:flutter/material.dart';

class ScreenUtils {
  static Future<dynamic> modal(
      {required BuildContext context,
      required String text,
      required String greenButtonText,
      required String redButtonText,
      String warning = '',
      required Function()? redOnpressed,
      required Function()? greenOnpressed}) {
    // Apply padding only the warning text is not empty
    EdgeInsetsGeometry emptyWarningPadding() {
      if (warning == '') {
        return const EdgeInsets.only(top: 0.0);
      } else {
        return const EdgeInsets.only(top: 15.0);
      }
    }

    // App Dialog
    getShowDialog() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
              padding: const EdgeInsets.fromLTRB(35.0, 54.0, 34.0, 54.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    text,
                    style: MediaQuery.of(context).size.width > 350.0
                        ? const TextStyle(fontSize: 16.0)
                        : const TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: emptyWarningPadding(),
                    child: Text(
                      warning,
                      style: TextStyle(
                        color: const Color.fromRGBO(255, 0, 0, 1),
                        fontSize: MediaQuery.of(context).size.width > 350.0
                            ? 16.0
                            : 12.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: [
                        ElevatedButton(
                          onPressed: redOnpressed,
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromRGBO(255, 0, 0, 1)),
                            elevation: MaterialStatePropertyAll(0.0),
                          ),
                          child: Text(
                            redButtonText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width > 350.0
                                      ? 16.0
                                      : 12.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        ElevatedButton(
                          onPressed: greenOnpressed,
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromRGBO(48, 190, 113, 1),
                            ),
                            elevation: MaterialStatePropertyAll(0.0),
                          ),
                          child: Text(
                            greenButtonText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width > 350.0
                                      ? 16.0
                                      : 12.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return getShowDialog();
  }
}
