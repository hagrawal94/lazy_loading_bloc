import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:untitled/logic/models/item.dart';
import '../../config.dart';
import 'add_item_screen_event.dart';
import 'add_item_screen_state.dart';

class AddItemScreenBloc extends Bloc<AddItemScreenEvent, AddItemScreenState> {
  AddItemScreenBloc();

  @override
  get initialState => AddItemScreenInitial();

  @override
  Stream<AddItemScreenState> mapEventToState(event) async* {
    if (event is AddItemScreenUploadEvent) {
      try{
        yield AddItemScreenUploading();
        Item item = event.getItem();
        String url = basePostUrl+"&name=${item.name}&description=${item.description}&lastSubmittedDate=${item.lastSubmittedDate}&marks=${item.marks}";
        final req = MultipartRequest("POST", Uri.parse(url));
        final multipartFile1 = MultipartFile(
            'file', ByteStream.fromBytes(event.getFile().readAsBytesSync()), event.getFile().readAsBytesSync().length,
            filename: item.attachFileName);
        req.headers.addAll({"Authorization":authToken});
        req.files.add(multipartFile1);
        final response = await req.send();
        print(req.url);
        print(response.statusCode);
        if (response.statusCode == 201)
          yield AddItemScreenUploadSuccess();
        else yield AddItemScreenUploadFail();
      }catch(error) {
        yield AddItemScreenUploadFail();
      }
    }
  }
}
