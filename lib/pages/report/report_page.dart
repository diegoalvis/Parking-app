import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  Future<File> imageFile;

  pickImage(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        return Image.file(
          snapshot.data,
          fit: BoxFit.fill,
          width: 410,
          height: 250,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reportar",
            style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400)),
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: <Widget>[
                        ListTile(
                            leading: Icon(
                              Icons.photo_camera,
                            ),
                            title: Text("Camara"),
                            onTap: () {
                              pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            }),
                        ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text("Galeria"),
                            onTap: () {
                              pickImage(ImageSource.gallery);
                              Navigator.pop(context);
                            }),
                      ],
                    );
                  });
            },
            child: imageFile == null
                ? Stack(
                    children: <Widget>[
                      Container(
                        height: 250,
                        color: Color.fromARGB(210, 55, 55, 55),
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Color.fromARGB(255, 200, 200, 200),
                            size: 60.0,
                          ),
                        ),
                      ),
                    ],
                  )
                : showImage(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30, bottom: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Observaciones",
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: '¿ Que ocurrio ?',
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(const Radius.circular(30.0)))),
              validator: _validateObs,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Text('CANCELAR'),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    child: Text('ENVIAR', style: TextStyle(color: Colors.white)),
                    color: Theme.of(context).accentColor,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _validateObs(String value) {
    if (value == '')
      return 'Las observaciones son obligatorias';
    else
      return null;
  }
}
