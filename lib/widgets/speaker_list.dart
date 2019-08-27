import 'package:flutter/material.dart';
import 'package:it_forum_omsk/widgets/speaker_container.dart';
import 'package:it_forum_omsk/widgets/speaker_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SpeakerList extends StatefulWidget {
  @override
  _SpeakerList createState() => _SpeakerList();
}

class _SpeakerList extends State<SpeakerList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('speakers')
          .document('document_speakers')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.data['array_speakers'].length,
              itemBuilder: (context, index) {
                var data = snapshot.data.data['array_speakers'][index];
                return GestureDetector(
                  child: SpeakerContainer(data, 2.0),
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SpeakerCard(data, index),
                      ),
                    );
                  },
                );
              },
            );
        }
      },
    );
  }
}