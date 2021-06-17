class HomeEvent {}

class HomeLoadEvent extends HomeEvent {

  final int page;

  HomeLoadEvent(this.page);

  int getPage() => page;
}

