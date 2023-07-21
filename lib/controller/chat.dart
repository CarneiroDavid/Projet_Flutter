import 'package:flutter/material.dart';
import 'package:ipssisqy2023/controller/ChatBubble.dart';
import 'package:ipssisqy2023/controller/firestore_helper.dart';
import 'package:ipssisqy2023/globale.dart';
import 'package:ipssisqy2023/model/my_user.dart';

class UserChat extends StatefulWidget {
  MyUser user;
  UserChat({super.key, required this.user});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  TextEditingController msg = TextEditingController();
  List listMsg = [];


  @override
  void initState() {
    // TODO: implement initState
    widget.user.convs?.forEach((conv) {
      if(conv['sendTo'] == me.id) {
        setState(() {
          listMsg.add(conv);
        });
      }

    });
    me.convs?.forEach((conv) {
      if(conv['sendTo'] == widget.user.id){
        setState(() {
          listMsg.add(conv);
        });
      }
    });
    setState(() {
      listMsg.sort((a,b) => a['date'].compareTo(b['date']));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.user.fullName),
          backgroundColor: Colors.purple,
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: listMsg.length,
            itemBuilder: (context,idx) {
              var msgToDisplay = listMsg[idx];
              // return SizedBox(
              //   height:80,
              //
              //   child: Card(
              //     color: (msgToDisplay['sendBy'] == me.id)?Colors.lightGreen:Colors.pinkAccent,
              //
              //     elevation: 15,
              //     child:Padding(
              //       padding: const EdgeInsets.all(12),
              //       child: Text(msgToDisplay['msg']),
              //     ),
              //   ),
              // );
              if(msgToDisplay['sendBy'] == me.id){
                return ChatBubble(text: msgToDisplay['msg'], isCurrentUser: true);
              }else{
                return ChatBubble(text: msgToDisplay['msg'], isCurrentUser: false);
              }
            }
        ),
        persistentFooterButtons: [
          ListTile(
            title:TextField(
                    controller: msg,
                    maxLength: 255,
                  ),
            trailing: IconButton(
                onPressed: (){
                  var map =
                    {
                    "sendBy": me.id,
                    "date": DateTime.now().toString(),
                    "sendTo": widget.user.id,
                    "msg": msg.text
                    };

                  FirestoreHelper().createMessage(me.id, map);
                  setState(() {
                    listMsg.add(map);
                  });
                  print(msg.text);
                },
                icon: Icon(Icons.send),color:Colors.purple),
          ),
        ],
      ),
    );
  }
}
