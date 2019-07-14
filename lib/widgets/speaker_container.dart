import 'package:flutter/material.dart';
import 'package:it_forum_omsk/blocs/speaker_bloc.dart';
import 'package:it_forum_omsk/models/model_speaker.dart';


class SpeakerContainer extends StatelessWidget {
  final Speaker speaker;
  final SpeakerBloc bloc;
  const SpeakerContainer(this.speaker, this.bloc);

  Widget _buildMenu(Speaker speaker, SpeakerBloc bloc, context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(7.0),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Color.fromRGBO(31, 32, 65, 0.8)),
        child: Container(
          height: 100,
          color: Color.fromRGBO(224, 224, 224, 1),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage("assets/avatars/speaker-${speaker.id}.png"),
                    radius: 32,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 90),
                child: Container(
                  width: MediaQuery.of(context).size.width - 130,
                  height: 80,
                  child: Stack(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: "${speaker.lastName} ${speaker.firstName} ${speaker.middleName}\n",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Color.fromRGBO(31, 32, 65, 0.8)),
                          children: <TextSpan>[
                            TextSpan(text: "${speaker.note}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Montserrat'),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMenu(this.speaker, this.bloc, context);
  }
}