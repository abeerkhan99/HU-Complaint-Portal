import 'dart:convert';

import '../src/flutter_flow/flutter_flow_drop_down.dart';
import '../src/flutter_flow/flutter_flow_icon_button.dart';
import '../src/flutter_flow/flutter_flow_theme.dart';
import '../src/flutter_flow/flutter_flow_util.dart';
import '../src/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'apikey.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _IdkkCopyWidgetState createState() => _IdkkCopyWidgetState();
}

class _IdkkCopyWidgetState extends State<CreatePost> {
  String? teamSelectValue;
  TextEditingController? shortBioController;
  TextEditingController? userNameController;
  TextEditingController? textController1;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final DropDownList = <String>[];
  var sid;

  @override
  void initState() {
    super.initState();
    shortBioController = TextEditingController();
    userNameController = TextEditingController();
    textController1 = TextEditingController();
    GetDepartment();
  }

  @override
  void dispose() {
    shortBioController?.dispose();
    userNameController?.dispose();
    textController1?.dispose();
    super.dispose();
  }

  GetDepartment() async {
    dynamic id = await SessionManager().get("id");

    String APIURL = "http://10.0.2.2/index.php/hucp/getdepartment";
    http.Response response = await http.get(Uri.parse(APIURL), headers: {"Authorization": APIkey.key});

    var data = jsonDecode(response.body);
    var message = data["message"];
    print(message);

    for (var i = 0; i < message.length; i++) {
      DropDownList.add(message[i][0].toString());
    }

    print(DropDownList);

    setState(() {
      sid = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
            Navigator.pushNamed(context, '/home').then((_) {
              // This block runs when you have returned back from screen 2.
              setState(() {
                // code here to refresh data
                GetDepartment();
              });
            });
          },
        ),
        title: Text(
          'Page Title',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Work Sans',
                color: FlutterFlowTheme.of(context).gray600,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: Color(0xFF821C8B),
                    unselectedLabelColor: Color(0xFF95A1AC),
                    labelStyle: GoogleFonts.getFont(
                      'Work Sans',
                      fontWeight: FontWeight.w500,
                    ),
                    indicatorColor: Color(0xFF821C8B),
                    indicatorWeight: 3,
                    tabs: [
                      Tab(
                        text: 'Report',
                      ),
                      Tab(
                        text: 'Lodge Complaint',
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 12),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x2E000000),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.96,
                                            height: 340,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 6,
                                                  color: Colors.white,
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              shape: BoxShape.rectangle,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 15, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: textController1,
                                                  onChanged: (_) =>
                                                      EasyDebounce.debounce(
                                                    'textController1',
                                                    Duration(
                                                        milliseconds: 2000),
                                                    () => setState(() {}),
                                                  ),
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Enter post details here...',
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 32, 20, 12),
                                                    suffixIcon: textController1!
                                                            .text.isNotEmpty
                                                        ? InkWell(
                                                            onTap: () async {
                                                              textController1
                                                                  ?.clear();
                                                              setState(() {});
                                                            },
                                                            child: Icon(
                                                              Icons.clear,
                                                              color: Color(
                                                                  0xFF757575),
                                                              size: 15,
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Work Sans',
                                                      ),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 6,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Create Post',
                                  options: FFButtonOptions(
                                    width: 200,
                                    height: 50,
                                    color: Color(0xFF821C8B),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'Work Sans',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
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
                        ),

                        // complaint post
                        Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 6, 0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.96,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x2E000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 15),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 16, 16, 0),
                                                    child: TextFormField(
                                                      controller:
                                                          userNameController,
                                                      onChanged: (_) =>
                                                          EasyDebounce.debounce(
                                                        'userNameController',
                                                        Duration(
                                                            milliseconds: 2000),
                                                        () => setState(() {}),
                                                      ),
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Complaint Title',
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFF1F4F8),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFF1F4F8),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(20,
                                                                    32, 20, 12),
                                                        suffixIcon:
                                                            userNameController!
                                                                    .text
                                                                    .isNotEmpty
                                                                ? InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      userNameController
                                                                          ?.clear();
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .clear,
                                                                      color: Color(
                                                                          0xFF757575),
                                                                      size: 15,
                                                                    ),
                                                                  )
                                                                : null,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .title3
                                                          .override(
                                                            fontFamily:
                                                                'Work Sans',
                                                            color: Color(
                                                                0xFF14181B),
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      validator: (value) {
                                                        // check if field is empty
                                                        if (value!.isEmpty) {
                                                          return "Please enter complaint title";
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 16, 16, 0),
                                                    child: TextFormField(
                                                      controller:
                                                          shortBioController,
                                                      onChanged: (_) =>
                                                          EasyDebounce.debounce(
                                                        'shortBioController',
                                                        Duration(
                                                            milliseconds: 2000),
                                                        () => setState(() {}),
                                                      ),
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Enter description here...',
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFF1F4F8),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFF1F4F8),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(20,
                                                                    32, 20, 12),
                                                        suffixIcon:
                                                            shortBioController!
                                                                    .text
                                                                    .isNotEmpty
                                                                ? InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      shortBioController
                                                                          ?.clear();
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .clear,
                                                                      color: Color(
                                                                          0xFF757575),
                                                                      size: 15,
                                                                    ),
                                                                  )
                                                                : null,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Work Sans',
                                                                color: Color(
                                                                    0xFF14181B),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 6,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      validator: (value) {
                                                        // check if field is empty
                                                        if (value!.isEmpty) {
                                                          return "Please enter complaint description";
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 12, 16, 0),
                                                    child: FlutterFlowDropDown(
                                                      options: DropDownList,
                                                      onChanged: (val) =>
                                                          setState(() =>
                                                              teamSelectValue =
                                                                  val),
                                                      width: double.infinity,
                                                      height: 60,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Work Sans',
                                                                color: Color(
                                                                    0xFF14181B),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                      hintText:
                                                          'Select Department',
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_rounded,
                                                        color:
                                                            Color(0xFF57636C),
                                                        size: 15,
                                                      ),
                                                      fillColor: Colors.white,
                                                      elevation: 2,
                                                      borderColor:
                                                          Color(0xFFF1F4F8),
                                                      borderWidth: 2,
                                                      borderRadius: 8,
                                                      margin:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24, 4, 12, 4),
                                                      hidesUnderline: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 25, 0, 0),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            // if fields are not empty
                                            // send data to api to get checked
                                            if (teamSelectValue == null) {
                                              final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Select a department!'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              CreateComplaint();
                                            }
                                          } else {
                                            return;
                                          }
                                        },
                                        text: 'Create Complaint',
                                        options: FFButtonOptions(
                                          width: 200,
                                          height: 50,
                                          color: Color(0xFF821C8B),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily: 'Work Sans',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          // borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future CreateComplaint() async {
    String APIURL = "http://10.0.2.2/index.php/hucp/addcomplaint";

    var json_body = {
      'id': sid,
      'title': userNameController!.text,
      'description': shortBioController!.text,
      'department': teamSelectValue
    };

    print(json_body);

    http.Response response =
        await http.post(Uri.parse(APIURL), headers: {"Authorization": APIkey.key}, body: json_body);

    var data = jsonDecode(response.body);
    var message = data["message"];
    print(message);

    if (message == "true") {
      Navigator.pop(context);
    } else {
      final snackBar = SnackBar(
          content: const Text('Could not add complaint. Please try again'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
