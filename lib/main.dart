import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(int currentState, CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
      case CounterEvent.increment:
        yield currentState + 1;
        break;
      default:
    }
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => myAppState();
}

class myAppState extends State<MyApp> {
  final CounterBloc _counterBloc = CounterBloc();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CounterBloc>(
        bloc: _counterBloc,
        child: MyHomePage(),
      ),
    );
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }
}

// BLOC

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Counter"),
//       ),
//       body: Center(
//         child: BlocBuilder<CounterEvent, int>(
//           bloc: _counterBloc,
//           builder: (BuildContext context, int count) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   '!You have pushed the button this many times:',
//                 ),
//                 Text(
//                   '$count',
//                   style: Theme.of(context).textTheme.display1,
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//       floatingActionButton: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Padding(
//             child: FloatingActionButton(
//               onPressed: () {
//                 _counterBloc.dispatch(CounterEvent.increment);
//               },
//               tooltip: 'Increment',
//               child: Icon(Icons.add),
//             ),
//             padding: EdgeInsets.symmetric(vertical: 20),
//           ),
//           Padding(
//             child: FloatingActionButton(
//               onPressed: () {
//                 _counterBloc.dispatch(CounterEvent.decrement);
//               },
//               tooltip: 'Decrement',
//               child: Icon(Icons.remove),
//             ),
//             padding: EdgeInsets.symmetric(vertical: 15),
//           )
//         ],
//       ),
//     );
//   }
// }


//SetState

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(child: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), padding: EdgeInsets.symmetric(vertical: 20),),
          Padding(child: FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ), padding: EdgeInsets.symmetric(vertical: 15),)
        ],
      ),
    );
  }
}
