import 'package:flutter/material.dart';

Future<bool> askModal(BuildContext context, String question) {
  return Navigator.push(context,PageRouteBuilder(
    opaque: false,
    pageBuilder: (context,_,__) {
     return AskModal(question: question,);  
    }
  ));
}



class AskModal extends StatelessWidget {
  final String question;

  AskModal({this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.black54,
      alignment: Alignment.center,
      child: Card(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(question),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                RaisedButton(
                  child: Text("ok",style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  color: Colors.blue,
                ),
                RaisedButton(
                  child: Text("annuler",style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.pop(context,false);
                  },
                  color: Colors.red,
                )
              ],)
            ],
          ),
        ),
      ),
    );
  }
}