import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:untitled/config.dart';
import 'package:untitled/logic/models/item.dart';

import 'home_screen_event.dart';
import 'home_screen_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  List<Item> items;

  HomeBloc(this.items);

  @override
  get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(event) async* {
    if (event is HomeLoadEvent) {
      try {
        if(event.getPage()==0){
          items = [];
          yield HomeLoadingState();
        }
        final response = await get(Uri.parse(baseURL+event.getPage().toString()), headers: {"Authorization":authToken});
        final extractedData = json.decode(response.body);
        extractedData.forEach((itemData) {
          items.add(Item.fromJson(itemData));
        });
        if (items.length<1) {
          yield HomeNoDataState();
        }
        yield HomeLoadedState(
          launches: items,
        );
      } catch (error) {
        yield HomeErrorState();
      }
    }
  }
}