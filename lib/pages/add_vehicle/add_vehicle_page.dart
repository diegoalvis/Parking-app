import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:oneparking_citizen/util/widget_util.dart';
import 'package:oneparking_citizen/pages/add_vehicle/add_vehicle_bloc.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';

class AddVehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindSingleton(AddVehicleBloc(InjectorWidget.of(context).get()));
        },
        child: AddVehicle());
  }
}

class AddVehicle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddVehicleState();
}

class AddVehicleState extends State<AddVehicle> {
  final _focusTradeMark = FocusNode();
  final _focusLicensePlate = FocusNode();
  final _formKey = GlobalKey<FormState>();
  AddVehicleBloc _bloc;
  bool _autoValidate = false;
  var _radioBtnDefault = -1;
  VehicleBase vehicleBase = VehicleBase();

  final _tradeMarkCtrl = TextEditingController();
  final _licensePlateCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tradeMarkCtrl.dispose();
    _licensePlateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<AddVehicleBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar vehiculo",
            style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w400)),
      ),
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 60, bottom: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.text,
                focusNode: _focusTradeMark,
                controller: _tradeMarkCtrl,
                decoration: InputDecoration(
                    labelText: 'Marca de vehiculo',
                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(const Radius.circular(30.0)))),
                textInputAction: TextInputAction.next,
                validator: _validateTradeMark,
                onFieldSubmitted: (v) {
                  /*setState(() {
                    vehicleBase.brand = _tradeMarkCtrl.text;
                  });*/
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
                controller: _licensePlateCtrl,
                /*onFieldSubmitted: (v) {
                  setState(() {
                    vehicleBase.plate = _licensePlateCtrl.text;
                  });
                },*/
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
                    onWidgetDidBuild(() {
                      Navigator.pop(context);
                    });
                  }

                  if (state is LoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else
                    return Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, right: 20.0),
                          child: RaisedButton(
                            child: Text('AGREGAR', style: TextStyle(color: Colors.white)),
                            color: Theme.of(context).accentColor,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            onPressed: _add,
                          ),
                        ),
                      ),
                    );
                }),
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
          return vehicleBase.type = TYPE_CAR;
          break;
        default:
          return vehicleBase.type = TYPE_MOTORCYCLE;
          break;
      }
    });
  }

  _add() {
    if (_formKey.currentState.validate()) {
      setState(() {
        vehicleBase.brand = _tradeMarkCtrl.text;
        vehicleBase.plate = _licensePlateCtrl.text;
      });
      _bloc.dispatch(AddVehicleEvent(vehicleBase));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
