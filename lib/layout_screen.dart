import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Layout'),
      // ),
      body: SafeArea(
        top: true,
        bottom: false,
        left: true,
        right: false,
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    // Column, Row
    // SizedBox, Wrap
    // Expand, Flexible
    // Stack, IndexStack

    return Container(
      color: Colors.yellow,
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      child: IndexedStack(
        index: 2,
        children: [
          Container(color: Colors.red),
          Container(color: Colors.blue),
          Container(color: Colors.green),
        ],
      ),
    );

    // return Container(
    //   color: Colors.yellow,
    //   width: double.infinity,
    //   height: MediaQuery.of(context).size.height / 3,
    //   child: Stack(
    //     alignment: AlignmentDirectional.center,
    //     children: [
    //       blueBox(),
    //       Positioned(
    //         left: 10,
    //         bottom: 10,
    //         child: blueBox(),
    //       ),
    //       Positioned(
    //         right: 10,
    //         child: blueBox(),
    //       ),
    //     ],
    //   ),
    // );

    // return Container(
    //   color: Colors.yellow,
    //   child: Row(
    //     children: [
    //       Flexible(child: Text('abc abc sdfgsdfgsdfgsdf gs dfg sdf g sdf gs df gs dfg sd fg sdf ', overflow: TextOverflow.fade, style: TextStyle(backgroundColor: Colors.red),)),
    //
    //       Text('Ho ten'),
    //     ],
    //   ),
    // );

    // return Container(
    //   child: Row(
    //     children: [
    //       Expanded(child: blueBox(), flex: 1,),
    //       Expanded(child: blueBox(), flex: 2,),
    //       Expanded(child: blueBox(), flex: 1,),
    //     ],
    //   ),
    // );

    // return Container(
    //   child: Wrap(
    //     direction: Axis.horizontal,
    //     verticalDirection: VerticalDirection.down,
    //     runSpacing: 8,
    //     spacing: 16,
    //     children: [
    //       blueBox(),
    //       blueBox(),
    //       blueBox(),
    //     ],
    //   ),
    // );

    // return Container(
    //   height: double.infinity,
    //   child: Row(
    //     children: [
    //       blueBox(),
    //       blueBox(),
    //       blueBox(),
    //     ],
    //   ),
    // );

    // return Container(
    //   color: Colors.yellow,
    //   width: double.infinity,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     crossAxisAlignment: CrossAxisAlignment.end,
    //     children: [
    //       blueBox(),
    //       blueBox(),
    //       blueBox(),
    //     ],
    //   ),
    // );
  }

  Widget blueBox() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
