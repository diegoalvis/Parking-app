import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneparking_citizen/pages/report/report_bloc.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/data/models/incident.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindSingleton(IncidentBloc(InjectorWidget.of(context).get()));
        },
        child: IncidentPage());
  }
}

class IncidentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IncidentPageState();
}

class IncidentPageState extends State<IncidentPage> {
  File imageFile;
  IncidentBloc _bloc;
  final _obsController = TextEditingController();
  Zone _zone;

  pickImage(ImageSource source) {
    ImagePicker.pickImage(source: source).then((value) => setState(() {
          imageFile = value;
        }));
  }

  Widget showImage() {
    return Image.file(
      imageFile,
      fit: BoxFit.cover,
      width: 410,
      height: 179,
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    _obsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _zone = ModalRoute.of(context).settings.arguments;

    final _incidentZone = IncidentZone(idZone: _zone.idZone, name: _zone.name, code: _zone.code);

    _bloc = InjectorWidget.of(context).get<IncidentBloc>();
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
              controller: _obsController,
              validator: _validateObs,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  labelText: '¿ Que ocurrio ?',
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(const Radius.circular(30.0)))),
            ),
          ),
          //Spacer(),
          BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is ErrorState) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Text(
                    state.msg,
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                );
              } else {
                return Spacer();
              }
            },
          ),
          BlocBuilder(
              bloc: _bloc,
              builder: (context, state) {
                if (state is SuccessState) {
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: Text("Reporte enviado correctamente"),
                    duration: Duration(milliseconds: 800),
                  ));
                }
                if (state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else
                  return Padding(
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
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            onPressed: () {
                              _bloc.dispatch(
                                  IncidentEvent(imageFile, _obsController.text, _incidentZone));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
              }),
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
