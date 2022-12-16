import 'dart:convert';

import 'package:timeago/timeago.dart';

import '../src/flutter_flow/flutter_flow_animations.dart';
import '../src/flutter_flow/flutter_flow_theme.dart';
import '../src//flutter_flow/flutter_flow_util.dart';
import '../src/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'forgot_pass.dart';
import 'home.dart';
import 'edit-profile.dart';
import 'view-complaint.dart';
import 'main.dart';
import 'apikey.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<Login> with TickerProviderStateMixin {
  TextEditingController? textController1;
  TextEditingController? textController2;

  String? _email;
  String? _pass;

  bool formatfail = false;
  bool empty = false;
  bool loginfail = false;

  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: scaffoldKey,
              child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, -0.05),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(22, 50, 0, 0),
                          child: Text(
                            'HU Complaint Portal',
                            style: GoogleFonts.getFont(
                              'Work Sans',
                              fontWeight: FontWeight.w300,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 55, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    22, 50, 0, 20),
                                child: Text(
                                  'Login',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 32,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                              child: TextFormField(
                                controller: textController1,
                                onChanged: (_) => EasyDebounce.debounce(
                                  'textController1',
                                  Duration(milliseconds: 2000),
                                  () => setState(() {}),
                                ),
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  errorStyle:
                                      const TextStyle(fontFamily: 'Poppins'),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF50D36),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF50D36),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: textController1!.text.isNotEmpty
                                      ? InkWell(
                                          onTap: () async {
                                            textController1?.clear();
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            color: Color(0xFF757575),
                                            size: 15,
                                          ),
                                        )
                                      : null,
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                validator: (value) {
                                  // check if field is empty
                                  if (value!.isEmpty) {
                                    return "Please enter an email address";
                                  }
                                  // check if email format is correct
                                  else if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@st.habib.edu.pk")
                                      .hasMatch(value)) {
                                    return "Incorrect email format";
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                              child: TextFormField(
                                controller: textController2,
                                autofocus: true,
                                obscureText: !passwordVisibility,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF50D36),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF50D36),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFF757575),
                                      size: 15,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter a password";
                                  }
                                },
                              ),
                            ),
                            Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 20),
                                child: new InkWell(
                                    child: new Text("Forgot your password?",
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPass()),
                                      );
                                    })

                                // child: Text(
                                //   'Forgot your password?',
                                //   style: FlutterFlowTheme.of(context).bodyText1,

                                // ),
                                ),
                            FFButtonWidget(
                              onPressed: () {
                                if (scaffoldKey.currentState!.validate()) {
                                  // if fields are not empty
                                  // send data to api to get checked
                                  SendLoginData();
                                } else {
                                  return;
                                }
                              },
                              text: 'Login',
                              options: FFButtonOptions(
                                width: 130,
                                height: 40,
                                color: Color(0xFF821C8B),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                // borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            )),
      ),
    );
  }

  Future SendLoginData() async {

    String APIURL = "http://10.0.2.2/index.php/hucp/login";

    var json_body = {
      'email': textController1!.text,
      'password': textController2!.text
    };

    print(json_body);

    http.Response response = await http.post(Uri.parse(APIURL),
        headers: {"Authorization": APIkey.key}, body: json_body);

    var data = jsonDecode(response.body);
    var message = data["message"];
    print(message);
    if (message == "true") {
      var sessionManager = SessionManager();
      await sessionManager.set("id", data["id"]);
      await sessionManager.set("fname", data["fname"]);
      await sessionManager.set("lname", data["lname"]);
      await sessionManager.set("program", data["program"]);
      await sessionManager.set("batch", data["batch"]);
      await sessionManager.set("email", textController1!.text);
      await sessionManager.set("password", textController2!.text);

      bool? result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Home()),
      );
      print(result);
      if (result == null) {
        //Show SnackBar
        final snackBar =
            SnackBar(content: const Text('Successfully logged out!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        textController2!.text = '';
        textController1!.text = '';

        await SessionManager().destroy();
      }
    } else {
      final snackBar =
          SnackBar(content: const Text('Incorrect email or password'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
