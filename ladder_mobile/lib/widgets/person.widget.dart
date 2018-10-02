import 'package:flutter/material.dart';
import './raised-icon-button.widget.dart';
import '../models/person.model.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PersonWidget extends StatelessWidget{

  final Person person;
  final Person me;
  
  final TextStyle _nameStyle = new TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );
  final TextStyle _pointStyle = new TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.grey.shade200,
    fontSize: 14.0,
  );
  PersonWidget({this.person, this.me});

  @override
  Widget build(BuildContext ctx) => new ExpansionTile(
    title: new Text(this.person.name, style: this._nameStyle),
    trailing: new Text(this.person.points.toString(), style: this._pointStyle),
    backgroundColor: Colors.transparent,
    children: [
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RaisedIconButton(
            icon: const Icon(Icons.plus_one),
            label: new Text('Gottem!', 
              style: new TextStyle(fontWeight: FontWeight.w800)
            ),
            onPressed: () async {
              try {
                dynamic resp = CloudFunctions.instance.call(
                  functionName: 'reportMatch',
                  parameters: {
                    'winner': this.me.name,
                    'loser': this.person.name,
                  }
                );
                debugPrint(resp.toString());
              } catch (error) {
                debugPrint(error.toString());
              }
            },
          )
        ],
      )
    ],
  );

}

/**
 * new Padding(
    padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        new Text(this.person.name, style: _nameStyle),
        new Text(this.person.points.toString(), style: _pointStyle),
      ]
    )
  );
 */