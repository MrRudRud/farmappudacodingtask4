import 'package:farmapp_udacoding/views/page_register_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:farmapp_udacoding/views/page_home_view.dart';
import 'package:farmapp_udacoding/widgets/constans.dart';

// import 'package:flutter_week3/main.dart';
// import 'package:flutter_week3/shared_preferences.dart/page_home.dart';
// import 'package:flutter_week3/shared_preferences.dart/page_register.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

enum statusLogin { signIn, notSignIn }

class _PageLoginState extends State<PageLogin> {
  statusLogin _loginStatus = statusLogin.notSignIn;
  final _keySneak = GlobalKey<ScaffoldState>();
  final _keyForm = GlobalKey<FormState>();
  String nUsername, nPassword;

  bool _obscureText = true;

  // Cek Form ketika klik tombol login
  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      submitDataLogin();
    }
  }

  // Mengirim request dan callback data
  submitDataLogin() async {
    final responseData = await http.post("$baseUrl/login.php", body: {
      "username": nUsername,
      "password": nPassword,
    });

    final data = jsonDecode(responseData.body);
    print(data);

    // get data & response
    int value = data['value'];
    String pesan = data['message'];
    String dataUsername = data['username'];
    String dataEmail = data['email'];
    String dataTanggalDaftar = data['tgl_daftar'];
    String dataIdUser = data['id_user'];

    // cek value 1 or 0 (true/false)
    if (value == 1) {
      setState(() {
        // set status loginnya sbg login
        _loginStatus = statusLogin.signIn;
        print(_loginStatus);
        // simpan data ke shared preferences
        saveDataPref(
            value, dataIdUser, dataUsername, dataEmail, dataTanggalDaftar);
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      _snackBar(pesan);
    }
  }

  void _snackBar(String pesan) {
    _keySneak.currentState.showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
          Text(
            "$pesan",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.orange,
    ));
  }

  // method untuk simpan ke shared preferences
  saveDataPref(int value, String dataIdUser, String dataUsername,
      String dataEmail, String dataTanggalDaftar) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setInt("value", value);
      sharedPreferences.setString("username", dataUsername);
      sharedPreferences.setString("id_user", dataUsername);
      sharedPreferences.setString("email", dataEmail);
      sharedPreferences.setString("tgl_daftar", dataTanggalDaftar);
    });
  }

  // Method untuk cek user (Login atau blm) jk sudah set value
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
      print(_loginStatus);
    });
  }

  void initState() {
    getDataPref();
    super.initState();
  }

  // Method Sign out
  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", null);
      sharedPreferences.clear();
      _loginStatus = statusLogin.notSignIn;
      print(_loginStatus);
    });
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          key: _keySneak,
          body: Form(
            key: _keyForm,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Text('Login',
                          style: Theme.of(context).textTheme.headline1),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        validator: (val) => val.length < 6
                            ? 'Username too short (min 6 character)'
                            : null,
                        onSaved: (val) => nUsername = val,
                        decoration: InputDecoration(
                          labelText: 'username',
                          hintText: 'Input username',
                          prefixIcon: Icon(Icons.people, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Please input password' : null,
                        onSaved: (val) => nPassword = val,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() => _obscureText = !_obscureText);
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.grey),
                          hintText: 'Password',
                          labelText: 'Input Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100.0),
                      child: MaterialButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Submit',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        onPressed: () {
                          setState(() {
                            checkForm();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: MaterialButton(
                        textColor: Colors.black,
                        child: Text(
                          'Belum punya akun? Silahkan Daftar',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageRegister(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        break;
      case statusLogin.signIn:
        return PageHome();
        break;
    }
  }
}
