import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:oneparking_citizen/pages/account/register_one_bloc.dart';
import 'package:oneparking_citizen/pages/account/widgets/account_base.dart';

class RegisterOnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindSingleton(RegisterOneBloc(InjectorWidget.of(context).get()));
        },
        child: AccountBase(child: RegisterOneForm()),
      );
}

class RegisterOneForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterOneFormState();
}

class RegisterOneFormState extends State<RegisterOneForm> {
  final _formKey = GlobalKey<FormState>();
  final _focusName = FocusNode();
  final _focusDoc = FocusNode();

  final _nameCtrl = TextEditingController();
  final _docCtrl = TextEditingController();
  bool _autoValidate = false;

  bool _disability = false;

  RegisterOneBloc _bloc;

  @override
  void dispose() {
    _bloc?.dispose();
    _nameCtrl.dispose();
    _docCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get();
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          Text('Crea una cuenta en tan solo dos pasos'),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(filled: true, labelText: 'Nombre'),
              textInputAction: TextInputAction.next,
              controller: _nameCtrl,
              focusNode: _focusName,
              validator: _validateInput,
              onFieldSubmitted: (v) {
                _focusName.unfocus();
                FocusScope.of(context).requestFocus(_focusDoc);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 40),
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              controller: _docCtrl,
              validator: _validateInput,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Identificación',
              ),
              focusNode: _focusDoc,
            ),
          ),
          CheckboxListTile(
            title: Text(
              'Uso celdas de parqueo de movilidad reducida',
              style: Theme.of(context).textTheme.caption,
            ),
            value: _disability,
            activeColor: Theme.of(context).accentColor,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (v) {
              setState(() {
                _disability = !_disability;
              });
            },
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textColor: Theme.of(context).accentColor,
                  child: Text('Atras'),
                ),
              ),
              Expanded(
                child: RaisedButton(
                  child: Text('Continuar'),
                  color: Theme.of(context).accentColor,
                  onPressed: _validateInputs,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String _validateInput(String value) {
    if (value == '')
      return 'El campo es obligatorio';
    else
      return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _bloc.dispatch(RegisterOneEvent(name: _nameCtrl.text, doc: _docCtrl.text, disability: _disability));
      Navigator.pushNamed(context, '/register-two');
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
