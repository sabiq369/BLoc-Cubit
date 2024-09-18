import 'package:bloc_cubit/bloc/user_bloc.dart';
import 'package:bloc_cubit/bloc/user_event.dart';
import 'package:bloc_cubit/bloc/user_state.dart';
import 'package:bloc_cubit/data/model/user_model.dart';
import 'package:bloc_cubit/data/repository/user_repository.dart';
import 'package:bloc_cubit/sample/bloc/counter_bloc.dart';
import 'package:bloc_cubit/sample/bloc/counter_event.dart';
import 'package:bloc_cubit/sample/bloc/counter_state.dart';
import 'package:bloc_cubit/sample/visibility/bloc/visibility_bloc.dart';
import 'package:bloc_cubit/sample/visibility/bloc/visibility_event.dart';
import 'package:bloc_cubit/sample/visibility/bloc/visibility_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => UserBloc(context.read<UserRepository>()),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          if (state is UserErrorState) {
            return Center(
              child: Text('Error'),
            );
          }
          if (state is UserSuccessState) {
            List<Datum> userList = state.userModel.data;
            return userList.isNotEmpty
                ? ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(userList[index].name),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text('No data found'),
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserBloc>().add(LoadUserEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text(
    //           'You have pushed the button this many times:',
    //         ),
    //         BlocConsumer<CounterBloc, CounterState>(
    //           listener: (context, state) {
    //             if (state.count == 3) {
    //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //                   content: Text('Counter value is ${state.count}')));
    //             }
    //           },
    //           builder: (context, state) {
    //             return Text(
    //               state.count.toString(),
    //               style: Theme.of(context).textTheme.headlineMedium,
    //             );
    //           },
    //         ),
    //         BlocBuilder<VisibilityBloc, VisibilityState>(
    //           builder: (context, state) {
    //             return Visibility(
    //                 visible: state.show,
    //                 child: Container(
    //                   width: 100,
    //                   height: 100,
    //                   color: Colors.purple,
    //                 ));
    //           },
    //         ),
    //         BlocListener<CounterBloc, CounterState>(
    //           listenWhen: (previous, current) => true,
    //           listener: (context, state) {
    //             if (state.count == 3) {
    //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //                   content: Text('Counter value is ${state.count}')));
    //             }
    //           },
    //           child: Text("You can't make child null"),
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       FloatingActionButton(
    //         onPressed: () =>
    //             context.read<CounterBloc>().add(CounterIncrementEvent()),
    //         tooltip: 'Increment',
    //         child: const Icon(Icons.add),
    //       ),
    //       FloatingActionButton(
    //         onPressed: () =>
    //             context.read<CounterBloc>().add(CounterDecrementEvent()),
    //         tooltip: 'Decrement',
    //         child: const Icon(Icons.minimize),
    //       ),
    //       FloatingActionButton(
    //         onPressed: () =>
    //             context.read<VisibilityBloc>().add(VisibilityShow()),
    //         child: const Text('Show'),
    //       ),
    //       FloatingActionButton(
    //         onPressed: () =>
    //             context.read<VisibilityBloc>().add(VisibilityHide()),
    //         child: const Text('Hide'),
    //       ),
    //     ],
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}
