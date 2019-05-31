import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/pages/account/register_two_bloc.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:oneparking_citizen/pages/account/widgets/account_base.dart';
import 'package:oneparking_citizen/pages/add_vehicle/add_vehicle_page.dart';
import 'package:oneparking_citizen/util/widget_util.dart';

class RegisterTwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindSingleton(RegisterTwoBloc(InjectorWidget.of(context).get()));
        },
        child: AccountBase(child: RegisterTwoForm()),
      );
}

class RegisterTwoForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterTwoFormState();
}

class RegisterTwoFormState extends State<RegisterTwoForm> {
  final _formKey = GlobalKey<FormState>();

  final _focusEmail = FocusNode();
  final _focusPass = FocusNode();
  final _focusConfirmPass = FocusNode();

  bool _obscure = true;

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _pass2Ctrl = TextEditingController();
  bool _autoValidate = false;

  RegisterTwoBloc _bloc;

  void _changeObscure() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  void dispose() {
    _bloc?.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _pass2Ctrl.dispose();
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
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(filled: true, labelText: 'Email'),
              textInputAction: TextInputAction.next,
              focusNode: _focusEmail,
              controller: _emailCtrl,
              validator: _validateEmail,
              onFieldSubmitted: (v) {
                _focusEmail.unfocus();
                FocusScope.of(context).requestFocus(_focusPass);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Contraseña',
                suffixIcon: GestureDetector(
                  onTap: _changeObscure,
                  child: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              textInputAction: TextInputAction.next,
              obscureText: _obscure,
              validator: _validatePass,
              controller: _passCtrl,
              focusNode: _focusPass,
              onFieldSubmitted: (v) {
                _focusPass.unfocus();
                FocusScope.of(context).requestFocus(_focusConfirmPass);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 60),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Confirmar Contraseña',
                suffixIcon: GestureDetector(
                  onTap: _changeObscure,
                  child: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              obscureText: _obscure,
              validator: _validatePass2,
              controller: _pass2Ctrl,
              focusNode: _focusConfirmPass,
            ),
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
          Spacer(),
          BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is SuccessState) {
                onWidgetDidBuild(() {
                  Navigator.pushReplacementNamed(context, '/add-vehicle', arguments: RegisterArguments(true));
                });
              }

              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Atras'),
                        textColor: Theme.of(context).accentColor,
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: _signin,
                        child: Text('Registrate'),
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value == '')
      return 'El email es obligatorio';
    else if (!regex.hasMatch(value))
      return 'El email tiene un mal formato';
    else
      return null;
  }

  String _validatePass(String value) {
    if (value == '')
      return 'La contraseña es obligatoria';
    else if (value.length < 5) return 'La contraseña debe tener almenos 6 caracteres';
    return null;
  }

  String _validatePass2(String value) {
    if (value == '')
      return 'Confirmar la contraseña es obligatorio';
    else if (value != _passCtrl.text) return 'La contraseñas no coinciden';
    return null;
  }

  _signin() {
    if (_formKey.currentState.validate()) {
      _bloc.dispatch(RegisterTwoEvent(email: _emailCtrl.text, pass: _passCtrl.text));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
