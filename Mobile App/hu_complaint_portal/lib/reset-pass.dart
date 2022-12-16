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


class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<ResetPassword>
    with TickerProviderStateMixin {
  TextEditingController? emailTextController;

  late bool passwordVisibility1;
  TextEditingController? passwordTextController;

  late bool passwordVisibility2;
  final scaffoldKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    emailTextController = TextEditingController();
    passwordVisibility1 = false;
    passwordTextController = TextEditingController();
    passwordVisibility2 = false;
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
      key: scaffoldKey,
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 75, 0, 0),
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
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: TextFormField(
                          controller: emailTextController,
                          autofocus: true,
                          obscureText: !passwordVisibility1,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                                () =>
                                    passwordVisibility1 = !passwordVisibility1,
                              ),
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                passwordVisibility1
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Color(0xFF757575),
                                size: 15,
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          validator: (value) {
                                  // check if field is empty
                                  if (value!.isEmpty) {
                                    return "Please enter a password";
                                  }
                                },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: passwordTextController,
                          autofocus: true,
                          obscureText: !passwordVisibility2,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                                () =>
                                    passwordVisibility2 = !passwordVisibility2,
                              ),
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                passwordVisibility2
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Color(0xFF757575),
                                size: 15,
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          validator: (value) {
                                  // check if field is empty
                                  if (value!.isEmpty) {
                                    return "Please enter a password";
                                  }
                                },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
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
                                  }),
                      ),
                      FFButtonWidget(
                        onPressed: () {
                          if (scaffoldKey.currentState!.validate()) {
                                // if fields are not empty
                                // send data to api to get checked
                                if(emailTextController!.text != passwordTextController!.text)
                                {
                                  final snackBar = SnackBar(content: const Text('Passwords do not match'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                }
                                else
                                {
                                   ResetData();
                                }
                               
                                
                              } else {
                                return;
                              }
                        },
                        text: 'Reset',
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: Color(0xFF821C8B),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
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
          )

        ),
      ),
    );
  }

  Future ResetData() async{
    
    String APIURL = "http://10.0.2.2/index.php/hucp/reset";

    dynamic id = await SessionManager().get("sid");
    dynamic e = await SessionManager().get("semail");

    var json_body = {
      'cpassword': passwordTextController!.text,
      'studentid': id,
      'email' : e
    };

    print(json_body);

    http.Response response = await http.post(Uri.parse(APIURL), body: json_body);

    var data = jsonDecode(response.body);
    var message = data["message"];
    print(message);
    if (message == "true") {

      Navigator.of(context)..pop()..pop();
      final snackBar =
          SnackBar(content: const Text('Password changed! Please login.'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // set snackbar to appear on login page

    } else {
      final snackBar =
          SnackBar(content: const Text('Could not change password'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
