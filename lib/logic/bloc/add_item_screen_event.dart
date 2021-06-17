
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:untitled/logic/models/item.dart';

class AddItemScreenEvent {}

class AddItemScreenUploadEvent extends AddItemScreenEvent {

  final Item uploadItem;
  final File file;

  AddItemScreenUploadEvent(this.uploadItem, this.file);

  Item getItem(){
    return uploadItem;
  }

  File getFile(){
    return file;
  }

}