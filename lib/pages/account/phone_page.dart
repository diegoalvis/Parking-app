import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:oneparking_citizen/pages/account/phone_bloc.dart';
import 'package:oneparking_citizen/pages/account/widgets/account_base.dart';

class PhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: InjectorWidget.bind(
          bindFunc: (binder) {
            binder.bindSingleton(PhoneBloc(InjectorWidget.of(context).get()));
          },
          child: AccountBase(child: PhoneForm()),
        ),
      );
}

class PhoneForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PhoneFormState();
}

class PhoneFormState extends State<PhoneForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  PhoneBloc _bloc;
  bool _autoValidate = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<PhoneBloc>();
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: _phoneCtrl,
            decoration: InputDecoration(filled: true, labelText: 'Celular'),
            validator: _validatePhone,
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    _bloc.dispatch(PhoneEvent());
                    Navigator.pop(context);
                  },
                  textColor: Theme.of(context).accentColor,
                  child: Text('Cancelar'),
                ),
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: _validateInputs,
                  color: Theme.of(context).accentColor,
                  child: Text('Crear Cuenta'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String _validatePhone(String value){
    if(value == '') return 'El campo de celular es obligatorio';
    else if (value.length < 10) return 'El celular tiene un mal formato';
    return null;
  }

  void _validateInputs(){
    if (_formKey.currentState.validate()) {
      _bloc.dispatch(PhoneEvent(phone:_phoneCtrl.text));
      Navigator.pushNamed(context, '/register-one');
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

}
