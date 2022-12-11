import 'dart:convert';

import '../src/flutter_flow/flutter_flow_animations.dart';
import '../src/flutter_flow/flutter_flow_theme.dart';
import '../src/flutter_flow/flutter_flow_util.dart';
import '../src/flutter_flow/flutter_flow_widgets.dart';
// import '../home_page/home_page_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'login.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<ForgotPass>
    with TickerProviderStateMixin {
  TextEditingController? emailTextController;
  TextEditingController? passwordTextController;
  final scaffoldKey = GlobalKey<FormState>();

  String? _studentid = "";
  String? _studentemail = "";

  @override
  void initState() {
    super.initState();

    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    emailTextController?.dispose();
    passwordTextController?.dispose();
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(22, 50, 0, 20),
                              child: Text(
                                'Reset Password',
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
                                controller: emailTextController,
                                onChanged: (_) => EasyDebounce.debounce(
                                      'emailTextController',
                                      Duration(milliseconds: 2000),
                                      () => setState(() {}),
                                    ),
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'StudentID',
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
                                  suffixIcon:
                                      emailTextController!.text.isNotEmpty
                                          ? InkWell(
                                              onTap: () async {
                                                emailTextController?.clear();
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
                                inputFormatters: [
                                  MaskTextInputFormatter(mask: 'AA#####')
                                ],
                                validator: (value) {
                                  // check if field is empty
                                  if (value!.isEmpty) {
                                    return "Please enter a student ID";
                                  }
                                },
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                            child: TextFormField(
                                controller: passwordTextController,
                                onChanged: (_) => EasyDebounce.debounce(
                                      'passwordTextController',
                                      Duration(milliseconds: 2000),
                                      () => setState(() {}),
                                    ),
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Email',
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
                                  suffixIcon:
                                      passwordTextController!.text.isNotEmpty
                                          ? InkWell(
                                              onTap: () async {
                                                passwordTextController?.clear();
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
                                keyboardType: TextInputType.emailAddress,
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
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                              child: new InkWell(
                                  child: new Text("Want to go back? Sign in",
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()),
                                    );
                                  })
                              // child: Text(
                              //   'Want to go back? Sign in',
                              //   style: FlutterFlowTheme.of(context).bodyText1,
                              // ),
                              ),
                          FFButtonWidget(
                            onPressed: () {
                              if (scaffoldKey.currentState!.validate()) {
                                // if fields are not empty
                                // send data to api to get checked
                                VerifyData();
                                
                              } else {
                                return;
                              }
                            },
                            text: 'Verify',
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
                ),
              ),
            )),
      ),
    );
  }

  Future VerifyData() async{
    
    String APIURL = "http://10.0.2.2/index.php/hucp/verify";

    var json_body = {
      'studentID': emailTextController!.text,
      'email': passwordTextController!.text
    };

    print(json_body);

    http.Response response = await http.post(Uri.parse(APIURL), body: json_body);

    var data = jsonDecode(response.body);
    var message = data["message"];
    print(message);
    if (message == "true") {

      var sessionManager = SessionManager();
      await sessionManager.set("sid", emailTextController!.text);
      await sessionManager.set("semail", passwordTextController!.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ForgotPass()),
      );
      

    } else {
      final snackBar =
          SnackBar(content: const Text('ID and Email not match'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
