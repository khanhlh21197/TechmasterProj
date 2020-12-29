import 'package:flutter/material.dart';
import 'package:techmaster_lesson_2/blocs/text_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.orange),
      // home: LayoutScreen(),
      home: TextScreen(),
    );
  }
}

class TextScreen extends StatefulWidget {
  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  TextBloc bloc = TextBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Screen'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Text 0',
            style: TextStyle(fontSize: 30),
          ),
          StreamBuilder<int>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('_TextScreenState.buildBody ${snapshot.data}');
                return Text(
                  '${snapshot.data}',
                  style: TextStyle(fontSize: 30),
                );
              }else{
                print('_TextScreenState.buildBody');
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          Row(
            children: [
              Expanded(
                  child: Text1(
                bloc: bloc,
              )),
              Expanded(
                  child: Text2(
                bloc: bloc,
              )),
            ],
          )
        ],
      ),
    );
  }
}

class Text1 extends StatefulWidget {
  final TextBloc bloc;

  const Text1({Key key, this.bloc}) : super(key: key);

  @override
  _Text1State createState() => _Text1State();
}

class _Text1State extends State<Text1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Text 1',
            style: TextStyle(fontSize: 30),
          ),
          StreamBuilder<int>(
            stream: widget.bloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '${snapshot.data}',
                  style: TextStyle(fontSize: 30),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          Row(
            children: [
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    widget.bloc.increase();
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    widget.bloc.decrease();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Text2 extends StatefulWidget {
  final TextBloc bloc;

  const Text2({Key key, this.bloc}) : super(key: key);

  @override
  _Text2State createState() => _Text2State();
}

class _Text2State extends State<Text2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Text 2',
            style: TextStyle(fontSize: 30),
          ),
          StreamBuilder<int>(
            stream: widget.bloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '${snapshot.data}',
                  style: TextStyle(fontSize: 30),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          Row(
            children: [
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    widget.bloc.increase();
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    widget.bloc.decrease();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//device info
//package info
//url launcher
//image picker
//web view
//shared preferences
//convert date time
//http

//lottie
