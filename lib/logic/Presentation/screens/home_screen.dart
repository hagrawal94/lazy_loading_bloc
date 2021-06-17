import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:untitled/logic/Presentation/screens/add_item_screen.dart';
import 'package:untitled/logic/bloc/home_screen_bloc.dart';
import 'package:untitled/logic/bloc/home_screen_event.dart';
import 'package:untitled/logic/bloc/home_screen_state.dart';
import 'package:untitled/logic/models/item.dart';

class HomeScreen extends StatefulWidget {

  final HomeBloc homeBloc;

  HomeScreen({Key key, this.homeBloc}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> launches;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddItemScreen(homeBloc: widget.homeBloc)));
        },
      ),
      appBar: AppBar(
        title: Text('Task'),
      ),
      body: Container(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (ctx, state) {
            if (state is HomeLoadingState) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is HomeLoadedState) {
              launches = state.launches;
              return LazyLoadScrollView(
                isLoading: state is HomeLoadingState,
                onEndOfPage: (){
                  print((launches.length/3).floor());
                  widget.homeBloc.add(HomeLoadEvent((launches.length/3).floor()));
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: launches.length,
                  itemBuilder: (_, index) {
                    final launch = launches[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(launch.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(launch.description),
                              Text("Due on: ${launch.lastSubmittedDate}", style: TextStyle(color: Colors.red),)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is HomeNoDataState) {
              return Container(
                child: Center(
                  child: Text('No data available'),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text('You have an error'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
