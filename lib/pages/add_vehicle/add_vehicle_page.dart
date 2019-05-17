import 'package:flutter/material.dart';

class AddVehiclePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddVehiclePageState();
}

class AddVehiclePageState extends State<AddVehiclePage> {
  final _focusTradeMark = FocusNode();
  final _focusLicensePlate = FocusNode();
  var _radioBtnDefault = -1;

  final _tradeMarkCtrl = TextEditingController();
  final _licensePlateCtrl = TextEditingController();

  @override
  void dispose() {
    _tradeMarkCtrl.dispose();
    _licensePlateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar vehiculo",
            style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400)),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 60, bottom: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.text,
                focusNode: _focusTradeMark,
                decoration: InputDecoration(
                    labelText: 'Marca de vehiculo',
                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(const Radius.circular(30.0)))),
                textInputAction: TextInputAction.next,
                validator: _validateTradeMark,
                onFieldSubmitted: (v) {
                  _focusTradeMark.unfocus();
                  FocusScope.of(context).requestFocus(_focusLicensePlate);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.text,
                focusNode: _focusLicensePlate,
                validator: _validateLicensePlate,
                decoration: InputDecoration(
                  labelText: 'Numero de placa',
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(const Radius.circular(30.0))),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: _radioBtnDefault,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Carro',
                  style: new TextStyle(fontSize: 16.0),
                ),
                Radio(
                  value: 1,
                  groupValue: _radioBtnDefault,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Moto',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 20.0),
                  child: RaisedButton(
                    child: Text('AGREGAR', style: TextStyle(color: Colors.white)),
                    color: Theme.of(context).accentColor,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validateLicensePlate(String value) {
    if (value == '')
      return 'La placa del vehiculo es obligatoria';
    else
      return null;
  }

  String _validateTradeMark(String value) {
    if (value == '')
      return 'La marca del vehiculo es obligatoria';
    else
      return null;
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioBtnDefault = value;

      switch (_radioBtnDefault) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }
}

class InputField extends StatelessWidget {
  final FocusNode focusNode;
  final Function(String value) validator;
  final String label;

  InputField(this.focusNode, this.validator, this.label);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: TextFormField(
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          validator: validator,
          decoration: InputDecoration(
            labelText: this.label,
            border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(const Radius.circular(30.0))),
          ),
        ),
      );
}
