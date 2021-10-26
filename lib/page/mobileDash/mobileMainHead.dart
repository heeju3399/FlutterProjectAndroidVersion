import 'package:flutter/material.dart';

class MobileMainHead extends StatelessWidget {
  MobileMainHead({Key key}) : super(key: key);

  final TextEditingController control = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Center(
                child: Container(
                    width: 410,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 5, color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(10))), //  POINT: BoxDecoration
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Expanded(
                          child: TextField(
                              controller: control,
                              onSubmitted: (text) {
                                print(text);
                                control.clear();
                              },
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(hintText: 'Search', contentPadding: EdgeInsets.only(left: 10, right: 10)))),
                      Container(
                          height: 50,
                          width: 50,
                          color: Colors.grey,
                          child: InkWell(
                              onTap: () {
                                print('click ${control.text}');
                                control.clear();
                              },
                              child: Icon(Icons.search, size: 25, color: Colors.white)))
                    ])))));
  }
}
