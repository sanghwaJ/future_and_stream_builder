import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreenStream extends StatefulWidget {
  const HomeScreenStream({Key? key}) : super(key: key);

  @override
  State<HomeScreenStream> createState() => _HomeScreenStreamState();
}

class _HomeScreenStreamState extends State<HomeScreenStream> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.0,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // FutureBuilder와 StreamBuilder 모두 아래와 같이 generic type을 지정해줄 수 있음
        // FutureBuilder와 StreamBuilder 모두 캐싱 기능이 있음
        child: StreamBuilder<int>(
          stream: streamNumbers(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'stream builder',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'ConState : ${snapshot.connectionState}', // done, active, waiting
                ),
                Text(
                  'data : ${snapshot.data}',
                ),
                Text(
                  'error : ${snapshot.error}',
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text(
                    'SetState',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // stream은 async*로 구현
  Stream<int> streamNumbers() async* {
    // 아래 loop가 다 돌아야 connectionState가 done 상태가 됨
    for (int i=0; i<10; i++) {
      await Future.delayed(Duration(seconds: 1));

      yield i;
    }
  }
}
