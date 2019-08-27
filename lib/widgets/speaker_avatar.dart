import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';


class SpeakerAvatar extends StatefulWidget {
  final speaker;
  final double radius;
  const SpeakerAvatar(this.speaker, this.radius);

  @override
  _SpeakerAvatar createState() => _SpeakerAvatar();
}

class _SpeakerAvatar extends State<SpeakerAvatar> with SingleTickerProviderStateMixin {

  var urlAvatar;
  static const colorContent = Color.fromRGBO(31, 32, 65, 0.8);

  @override
  void initState() {
    getUrl();
    super.initState();
  }

  Future getUrl() async {
    final StorageReference storageRef = FirebaseStorage.instance.ref().child(widget.speaker.path);
    var url =  await storageRef.getDownloadURL();
    setState(() {
      urlAvatar = url;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: urlAvatar == null ? null : Image.network(urlAvatar),
        radius: widget.radius,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorContent,
            blurRadius: 3.0,
          ),
        ],
      ),
    );
  }
}