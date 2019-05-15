import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:oneparking_citizen/pages/account/login_bloc.dart';
import 'package:oneparking_citizen/pages/account/widgets/account_base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:oneparking_citizen/util/widget_util.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.bindSingleton(LoginBloc(InjectorWidget.of(context).get()));
      },
      child: AccountBase(child: LoginForm()),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _focusEmail = FocusNode();
  final _focusPass = FocusNode();

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _autoValidate = false;

  bool _obscure = true;

  LoginBloc _bloc;

  @override
  void dispose() {
    _bloc?.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<LoginBloc>();
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            focusNode: _focusEmail,
            decoration: InputDecoration(filled: true, labelText: 'Email'),
            textInputAction: TextInputAction.next,
            validator: _validateEmail,
            onFieldSubmitted: (v) {
              _focusEmail.unfocus();
              FocusScope.of(context).requestFocus(_focusPass);
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 60),
            child: TextFormField(
              keyboardType: TextInputType.text,
              focusNode: _focusPass,
              obscureText: _obscure,
              validator: _validatePass,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Contraseña',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                  child: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                ),
              ),
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
                  Navigator.pushReplacementNamed(context, "/main");
                });
              }

              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        child: Text('Registrate'),
                        textColor: Theme.of(context).accentColor,
                        onPressed: () {
                          Navigator.pushNamed(context, '/register-phone');
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text('Entrar'),
                        color: Theme.of(context).accentColor,
                        onPressed: _login,
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
    else
      return null;
  }

  _login() {
    if (_formKey.currentState.validate()) {
      _bloc.dispatch(LoginEvent(email: _emailCtrl.text, pass: _passCtrl.text));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
