import 'dart:convert';
import 'package:hu_complaint_portal/view-profile.dart';

import '../src/flutter_flow/flutter_flow_icon_button.dart';
import '../src/flutter_flow/flutter_flow_count_controller.dart';
import '../src/flutter_flow/flutter_flow_drop_down.dart';
import '../src/flutter_flow/flutter_flow_theme.dart';
import '../src/flutter_flow/flutter_flow_util.dart';
import '../src/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'login.dart';
import 'main.dart';

class ViewComplaint extends StatefulWidget {
  const ViewComplaint({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<ViewComplaint> {
  String? dropDownValue;
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;
  TextEditingController? textController5;
  TextEditingController? textController6;

  late bool yourAgeVisibility1;
  TextEditingController? yourAgeController3;

  late bool yourAgeVisibility2;
  final scaffoldKey = GlobalKey<FormState>();

  int sbatch = 0;
  String? sprogram;

  final DropDownList = <String>[];

  var i;
  var t;
  var c;
  var dl;
  var rd;
  var d;
  var s;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: '');
    textController2 = TextEditingController(text: '');
    textController3 = TextEditingController(text: '');
    textController4 = TextEditingController(text: '');
    textController5 = TextEditingController(text: '');
    textController6 = TextEditingController(text: '');
    GetComplaintDetails();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    textController5?.dispose();
    super.dispose();
  }

  GetComplaintDetails() async {
    dynamic complaint_id = await SessionManager().get("complaint_id");
    dynamic title = await SessionManager().get("title");
    dynamic content = await SessionManager().get("content");
    dynamic ldate = await SessionManager().get("ldate");
    dynamic rdate = await SessionManager().get("rdate");
    dynamic department = await SessionManager().get("department");
    dynamic status = await SessionManager().get("status");

    String APIURL = "http://10.0.2.2/index.php/hucp/getdepartment";
    http.Response response = await http.get(Uri.parse(APIURL));

    var data = jsonDecode(response.body);
    var message = data["message"];
    print(message);

    for (var i = 0; i < message.length; i++) {
      DropDownList.add(message[i][0].toString());
    }

    print(DropDownList);

    setState(() {
      textController1!.text = title.toString();
      textController2!.text = content.toString();
      textController3!.text = ldate.toString();
      textController4!.text = rdate.toString();
      textController5!.text = status.toString();
      textController6!.text = department.toString();
      dropDownValue = department.toString();

      t = title.toString();
      c = content.toString();
      d = department.toString();
      s = status.toString();
      i = complaint_id.toString();
      rd = rdate.toString();

      print(t);
      print(c);
      print(d);
      print(s);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F4F8),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.chevron_left,
            color: Color(0xFF57636C),
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const Home()),
            // );
          },
        ),
        title: Text(
          'View Complaint',
          style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Work Sans',
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(),
          child: Form(
            key: scaffoldKey,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: textController1,
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController1',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        readOnly: (s != "Unresolved"),
                        decoration: InputDecoration(
                          labelText: 'Complaint Title',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF50D36),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF50D36),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                          suffixIcon: textController1!.text.isNotEmpty
                              ? InkWell(
                                  onTap: () async {
                                    if (s == "Unresolved") {
                                      textController1?.clear();
                                      setState(() {});
                                    }
                                  },
                                  child: Visibility(
                                    visible: (s == "Unresolved"),
                                    child: Icon(
                                      Icons.clear,
                                      color: Color(0xFF757575),
                                      size: 15,
                                    ),
                                  ))
                              : null,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Work Sans',
                            ),
                        validator: (value) {
                          // check if field is empty
                          if (value!.isEmpty) {
                            return "Please enter a complaint title";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: textController2,
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController2',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        readOnly: (s != "Unresolved"),
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF50D36),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF50D36),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                          suffixIcon: textController2!.text.isNotEmpty
                              ? InkWell(
                                  onTap: () async {
                                    if (s == "Unresolved") {
                                      textController2?.clear();
                                      setState(() {});
                                    }
                                  },
                                  child: Visibility(
                                    visible: (s == "Unresolved"),
                                    child: Icon(
                                      Icons.clear,
                                      color: Color(0xFF757575),
                                      size: 15,
                                    ),
                                  ))
                              : null,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                        validator: (value) {
                          // check if field is empty
                          if (value!.isEmpty) {
                            return "Please enter a description for your complaint";
                          }
                        },
                        maxLines: 6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: textController3,
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController3',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date Lodged',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF50D36),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF50D36),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Work Sans',
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: textController4,
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController4',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date Resolved',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF50D36),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF50D36),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Work Sans',
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: textController5,
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController5',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Current Status',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF50D36),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF50D36),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    // Align(
                    //   alignment: AlignmentDirectional(-0.77, 0),
                    //   child: Padding(
                    //     padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    //     child: Text(
                    //       'Department',
                    //       style: FlutterFlowTheme.of(context)
                    //           .bodyText1
                    //           .override(
                    //             fontFamily: 'Work Sans',
                    //             color: FlutterFlowTheme.of(context).grayDark,
                    //             fontSize: 11,
                    //           ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                        child: Column(
                          children: [
                            Visibility(
                              visible: (s != "Unresolved"),
                              child: TextFormField(
                                controller: textController6,
                                onChanged: (_) => EasyDebounce.debounce(
                                  'textController6',
                                  Duration(milliseconds: 2000),
                                  () => setState(() {}),
                                ),
                                obscureText: false,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Current Status',
                                  labelStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF50D36),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF50D36),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          20, 24, 20, 24),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            Visibility(
                              visible: (s == "Unresolved"),
                              child: FlutterFlowDropDown(
                                initialOption: dropDownValue,
                                options: DropDownList, //GET VALUES FROM API
                                onChanged: (val) =>
                                    setState(() => dropDownValue = val),
                                width: 320,
                                height: 45,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Work Sans',
                                      color: Colors.black,
                                    ),
                                hintText: sprogram,
                                fillColor: Color(0xFFF1F4F8),
                                elevation: 2,
                                borderColor: Colors.transparent,
                                borderWidth: 2,
                                borderRadius: 15,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            )
                          ],
                        )),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),






                        child: Column(children: [
                          Visibility(
                            visible: (s == "Unresolved"),
                            child: FFButtonWidget(
                          onPressed: () {
                            if (scaffoldKey.currentState!.validate()) {
                              if (textController1!.text == t.toString() &&
                                  textController2!.text == c.toString() &&
                                  dropDownValue == d.toString()) {
                                final snackBar = SnackBar(
                                    content: const Text(
                                        "You haven't changed any information!"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                UpdateComplaint();
                              }
                            } else {
                              return;
                            }
                          },
                          text: 'Save Changes',
                          options: FFButtonOptions(
                            width: 230,
                            height: 50,
                            color: Color(0xFF821C8B),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Work Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                    ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            // borderRadius: BorderRadius.circular(40),
                          ),
                        )
                         ),

                         Visibility(
                          visible: (s == "Resolved" && rd.isEmpty),
                          child: FFButtonWidget(
                          onPressed: () {
                            if (scaffoldKey.currentState!.validate()) {
                              if (textController4!.text.isEmpty) {
                                final snackBar = SnackBar(
                                    content: const Text(
                                        "You haven't add a resolved date!"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                Resolve();
                              }
                            } else {
                              return;
                            }
                          },
                          text: 'Resolve',
                          options: FFButtonOptions(
                            width: 230,
                            height: 50,
                            color: Color(0xFF821C8B),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Work Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                    ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            // borderRadius: BorderRadius.circular(40),
                          ),
                        )
                         )
                        ],)



                        
                        ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future Resolve() async {
    String APIURL = "http://10.0.2.2/index.php/hucp/resolve";

    var json_body = {'complaint_id': i};

    print(json_body);

    http.Response response =
        await http.post(Uri.parse(APIURL), body: json_body);

    var data = jsonDecode(response.body);

    var message = data["message"];
    print(message);

    if (message == "true") {
      var sessionManager = SessionManager();
      await sessionManager.set("rdate", message);

      Navigator.pop(context);
    } else {
      final snackBar = SnackBar(
          content:
              const Text('Complaint could not be updated. Please try again.'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future UpdateComplaint() async {
    // send complaint id, complaint title, complaint description, complaint status to API
    String APIURL = "http://10.0.2.2/index.php/hucp/updatecomplaint";

    var json_body = {
      'complaint_id': i,
      'complaint_title': textController1!.text,
      'complaint_content': textController2!.text,
      'complaint_department': dropDownValue.toString()
    };

    print(json_body);

    http.Response response =
        await http.post(Uri.parse(APIURL), body: json_body);

    var data = jsonDecode(response.body);
    var message = data["message"];
    print(message);
    if (message == "true") {
      Navigator.pop(context);
    } else {
      final snackBar = SnackBar(
          content:
              const Text('Complaint could not be updated. Please try again.'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
