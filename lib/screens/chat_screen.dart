import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgc = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser u1;
  String mtxt;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gcu();
  }

  void gcu() async {
    final n2 = await _auth.currentUser();
    if (n2 != null) {
      u1 = n2;
      print(u1.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.white70,
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('msgs')
                    .orderBy("t1", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final m3 = snapshot.data.documents;
                  List<Mbubble> l1 = [];
                  for (var m4 in m3) {
                    final mtext = m4.data['text'];
                    final msender = m4.data['sender'];
                    final cuser = u1.email;
                    final mwidget = Mbubble(msender, mtext, cuser == msender);
                    l1.add(mwidget);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      children: l1,
                    ),
                  );
                },
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: msgc,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          //Do something with the user input.
                          mtxt = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        msgc.clear();
                        //text = mtxt and sender = u1.email
                        _firestore.collection('msgs').add({
                          'text': mtxt,
                          'sender': u1.email,
                          't1': DateTime.now().millisecondsSinceEpoch,
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Mbubble extends StatelessWidget {
  final String s;
  final String t;
  final bool b;
  Mbubble(this.s, this.t, this.b);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            b ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text('$s'),
          Material(
            borderRadius: b
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            elevation: 8,
            color: b ? Colors.lightBlueAccent : Colors.green[300],
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$t',
                style: TextStyle(
                  color: b ? Colors.white : Colors.brown[900],
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
