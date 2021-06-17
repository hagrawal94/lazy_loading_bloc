import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/logic/bloc/add_item_screen_bloc.dart';
import 'package:untitled/logic/bloc/add_item_screen_state.dart';
import 'package:untitled/logic/bloc/add_item_screen_event.dart';
import 'package:untitled/logic/bloc/home_screen_bloc.dart';
import 'package:untitled/logic/bloc/home_screen_event.dart';
import 'package:untitled/logic/models/item.dart';

class AddItemScreen extends StatefulWidget {
  final HomeBloc homeBloc;

  AddItemScreen({Key key, this.homeBloc}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String testName;

  int marks;

  DateTime selectedDate = DateTime.now();

  String fileName, filePath;

  AddItemScreenBloc addItemScreenBloc;

  String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new item"),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => addItemScreenBloc = AddItemScreenBloc(),
          child: Container(
            child: BlocBuilder<AddItemScreenBloc, AddItemScreenState>(
              builder: (ctx, state) {
                if (state is AddItemScreenInitial ||
                    state is AddItemScreenUploadFail) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Test Name"),
                          TextField(
                            onChanged: (value) {
                              testName = value;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text("Max. Marks"),
                                      TextField(
                                        onChanged: (value) {
                                          marks = int.parse(value);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom:10.0),
                                        child: Text("Last Submit date, time"),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: selectedDate,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2025),
                                          ).then((value) {
                                            print("selectedDate: $value");
                                            if (value != null &&
                                                value != selectedDate)
                                              setState(() {
                                                selectedDate = value;
                                              });
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: Colors.grey),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text("Description"),
                          TextField(
                            onChanged: (value) {
                              description = value;
                            },
                          ),
                          TextButton(
                              onPressed: () async {
                                FilePickerResult res =
                                    await FilePicker.platform.pickFiles();
                                if (res != null) {
                                  fileName = res.files.single.name;
                                  filePath = res.files.single.path;
                                }
                                setState(() {});
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.attach_file),
                                  Text(fileName ?? "Attach File"),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                  onPressed: () {
                                    addItemScreenBloc.add(
                                      AddItemScreenUploadEvent(
                                          Item(
                                              name: testName,
                                              description: description,
                                              attachFileName: fileName,
                                              attachFilePath: filePath,
                                              lastSubmittedDate:
                                                  "${selectedDate.year}-${selectedDate.month < 10 ? "0${selectedDate.month}" : selectedDate.month}-${selectedDate.day} 16:50",
                                              marks: marks),
                                          File(filePath)),
                                    );
                                  },
                                  child: Text("Upload", style: TextStyle(color: Colors.white),)),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state is AddItemScreenUploading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  widget.homeBloc.add(HomeLoadEvent(0));
                  Navigator.of(context).pop();
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
