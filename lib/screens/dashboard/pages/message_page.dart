import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "Message",
          )),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (builder) => DestinationPage()));
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/face.png"),
                ),
                trailing: Text(
                  "11:30",
                  style:
                      TextStyle(color: colorBlack, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "I’m not a hoarder but I really...",
                  style:
                      TextStyle(color: colorBlack, fontWeight: FontWeight.bold),
                ),
                title: Text(
                  "Siliva",
                  style:
                      TextStyle(color: colorBlack, fontWeight: FontWeight.bold),
                ));
          }),
    );
  }
}
