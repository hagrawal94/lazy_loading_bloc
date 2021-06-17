import 'package:flutter/cupertino.dart';
import 'package:untitled/logic/models/item.dart';

class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeNoDataState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Item> launches;
  HomeLoadedState({
    @required this.launches,
  });
}

class HomeErrorState extends HomeState {}