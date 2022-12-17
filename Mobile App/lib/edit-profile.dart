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
import 'apikey.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfile> {
  String? dropDownValue;
  TextEditingController? yourAgeController1;
  TextEditingController? yourEmailController;
  TextEditingController? yourNameController;
  TextEditingController? yourAilmentsController;
  int countControllerValue = 0;
  TextEditingController? yourAgeController2;

  late bool yourAgeVisibility1;
  TextEditingController? yourAgeController3;

  late bool yourAgeVisibility2;
  final scaffoldKey = GlobalKey<FormState>();

  int sbatch = 0;
  String? sprogram;

  final DropDownList = <String>[];
  var i;
  var f;
  var l;
  var e;
  var p;
  var b;

  @override
  void initState() {
    super.initState();
    yourAgeController1 = TextEditingController(text: '');
    yourEmailController = TextEditingController(text: '');
    yourNameController = TextEditingController(text: '');
    yourAilmentsController = TextEditingController(text: '');
    yourAgeController2 = TextEditingController(text: '');
    yourAgeVisibility1 = false;
    yourAgeController3 = TextEditingController(text: '');
    yourAgeVisibility2 = false;
    getSessionValues();
  }

  @override
  void dispose() {
    yourAgeController1?.dispose();
    yourEmailController?.dispose();
    yourNameController?.dispose();
    yourAilmentsController?.dispose();
    yourAgeController2?.dispose();
    yourAgeController3?.dispose();
    super.dispose();
  }

  getSessionValues() async {
    dynamic id = await SessionManager().get("id");
    dynamic fname = await SessionManager().get("fname");
    dynamic lname = await SessionManager().get("lname");
    dynamic email = await SessionManager().get("email");
    dynamic program = await SessionManager().get("program");
    dynamic batch = await SessionManager().get("batch");

    String APIURL = "http://10.0.2.2/index.php/hucp/getprogram";
    http.Response response = await http
        .get(Uri.parse(APIURL), headers: {"Authorization": APIkey.key});

    var data = jsonDecode(response.body);
    var message = data["message"]; //["CS"],["EE"],["SDP"],["CND"]]

    for (var i = 0; i < message.length; i++) {
      DropDownList.add(message[i][0].toString());
    }

    print(DropDownList);

    setState(() {
      yourAgeController1!.text = id.toString();
      yourNameController!.text = fname.toString();
      yourEmailController!.text = lname.toString();
      yourAilmentsController!.text = email.toString();

      dropDownValue = program.toString();
      countControllerValue = batch;

      i = id.toString();
      f = fname.toString();
      l = lname.toString();
      e = email.toString();
      p = program.toString();
      b = batch.toString();
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
          },
        ),
        title: Text(
          'Edit Profile',
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
                        controller: yourNameController,
                        onChanged: (_) => EasyDebounce.debounce(
                          'yourNameController',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'First Name',
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
                          suffixIcon: yourNameController!.text.isNotEmpty
                              ? InkWell(
                                  onTap: () async {
                                    yourNameController?.clear();
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
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Work Sans',
                            ),
                        validator: (value) {
                          // check if field is empty
                          if (value!.isEmpty) {
                            return "Please enter a first name";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: yourEmailController,
                        onChanged: (_) => EasyDebounce.debounce(
                          'yourEmailController',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
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
                          suffixIcon: yourEmailController!.text.isNotEmpty
                              ? InkWell(
                                  onTap: () async {
                                    yourEmailController?.clear();
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
                            return "Please enter a last name";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: yourAgeController1,
                        onChanged: (_) => EasyDebounce.debounce(
                          'yourAgeController1',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'StudentID',
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
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: yourAilmentsController,
                        onChanged: (_) => EasyDebounce.debounce(
                          'yourAilmentsController',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                          suffixIcon: yourAilmentsController!.text.isNotEmpty
                              ? InkWell(
                                  onTap: () async {
                                    yourAilmentsController?.clear();
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
                          else if (!RegExp("^[a-zA-Z0-9+_.-]+@st.habib.edu.pk")
                              .hasMatch(value)) {
                            return "Incorrect email format";
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.77, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: Text(
                          'Batch',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Work Sans',
                                color: FlutterFlowTheme.of(context).grayDark,
                                fontSize: 11,
                              ),
                        ),
                      ),
                    ),
                    Container(
                      width: 320,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F4F8),
                        borderRadius: BorderRadius.circular(25),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color(0xFFF1F4F8),
                          width: 0,
                        ),
                      ),
                      child: FlutterFlowCountController(
                        decrementIconBuilder: (enabled) => FaIcon(
                          FontAwesomeIcons.minus,
                          color: enabled
                              ? FlutterFlowTheme.of(context).darkBackground
                              : Color(0xFFEEEEEE),
                          size: 20,
                        ),
                        incrementIconBuilder: (enabled) => FaIcon(
                          FontAwesomeIcons.plus,
                          color:
                              enabled ? Color(0xFF821C8B) : Color(0xFFEEEEEE),
                          size: 20,
                        ),
                        countBuilder: (count) => Text(
                          count.toString(),
                          style: GoogleFonts.getFont(
                            'Roboto',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        count: countControllerValue!, // CHANGE HERE
                        updateCount: (count) =>
                            setState(() => countControllerValue = count),
                        stepSize: 1,
                        minimum: 2018,
                        maximum: 2026,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.77, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Program',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Work Sans',
                                color: FlutterFlowTheme.of(context).grayDark,
                                fontSize: 11,
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                      child: FlutterFlowDropDown(
                        initialOption: dropDownValue.toString(),
                        options: DropDownList, //GET VALUES FROM API
                        onChanged: (val) => setState(() => dropDownValue = val),
                        width: 320,
                        height: 45,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Work Sans',
                                  color: Colors.black,
                                ),
                        hintText: dropDownValue.toString(),
                        fillColor: Color(0xFFF1F4F8),
                        elevation: 2,
                        borderColor: Colors.transparent,
                        borderWidth: 2,
                        borderRadius: 15,
                        margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                        hidesUnderline: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: yourAgeController2,
                        obscureText: !yourAgeVisibility1,
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => yourAgeVisibility1 = !yourAgeVisibility1,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              yourAgeVisibility1
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Color(0xFF757575),
                              size: 15,
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Work Sans',
                            ),
                        validator: (value) {
                          // check if field is empty
                          if (value!.isEmpty &&
                              yourAgeController3!.text.isNotEmpty) {
                            return "Please enter a password";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: yourAgeController3,
                        obscureText: !yourAgeVisibility2,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
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
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => yourAgeVisibility2 = !yourAgeVisibility2,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              yourAgeVisibility2
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Color(0xFF757575),
                              size: 15,
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Work Sans',
                            ),
                        validator: (value) {
                          // check if field is empty
                          if (value!.isEmpty &&
                              yourAgeController2!.text.isNotEmpty) {
                            return "Please enter a password";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                      child: FFButtonWidget(
                        onPressed: () {
                          if (scaffoldKey.currentState!.validate()) {
                            // if fields are not empty
                            // send data to api to get checked

                            if (f == yourNameController!.text &&
                                l == yourEmailController!.text &&
                                e == yourAilmentsController!.text &&
                                p == dropDownValue &&
                                b == countControllerValue.toString()) {
                              final snackBar = SnackBar(
                                  content: const Text(
                                      "You haven't changed any information!"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (yourAgeController2!.text !=
                                yourAgeController3!.text) {
                              print("Matching details");
                              final snackBar = SnackBar(
                                  content:
                                      const Text('Passwords do not match'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              print("Sending data");
                              SendNewData();
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
                          textStyle: FlutterFlowTheme.of(context)
                              .subtitle2
                              .override(
                                fontFamily: 'Work Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                              ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          // borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future SendNewData() async {
    String APIURL = "http://10.0.2.2/index.php/hucp/updateprofile";

    var json_body = {
      'id': yourAgeController1!.text,
      'fname': yourNameController!.text,
      'lname': yourEmailController!.text,
      'email': yourAilmentsController!.text,
      'program': dropDownValue.toString(),
      'batch': countControllerValue.toString(),
      'password': yourAgeController2!.text
    };

    print(json_body);

    http.Response response =
        await http.post(Uri.parse(APIURL), headers: {"Authorization": APIkey.key}, body: json_body);

    var data = jsonDecode(response.body);
    var message = data["message"];
    print(message);
    if (message == "true") {
      var sessionManager = SessionManager();

      await sessionManager.set("id", yourAgeController1!.text);
      await sessionManager.set("fname", yourNameController!.text);
      await sessionManager.set("lname", yourEmailController!.text);
      await sessionManager.set("program", dropDownValue.toString());
      await sessionManager.set("batch", countControllerValue.toString());
      await sessionManager.set("email", yourAilmentsController!.text);

      if (yourAgeController2!.text.isNotEmpty) {
        await sessionManager.set("password", yourAgeController2!.text);
      }
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => const Home()),
      // );

      Navigator.of(context).pop();
    } else {
      final snackBar = SnackBar(
          content:
              const Text('Could not update profile. Please try again later.'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
