import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreenFuture extends StatefulWidget {
  const HomeScreenFuture({Key? key}) : super(key: key);

  @override
  State<HomeScreenFuture> createState() => _HomeScreenFutureState();
}

class _HomeScreenFutureState extends State<HomeScreenFuture> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.0,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: getNumber(),
          // connectionState가 바뀔 때마다 builder 함수가 자동으로 재실행됨
          builder: (context, snapshot) {
            /**
             * snapshot 활용 방법
             */
            // if(snapshot.hasData) => 데이터가 있을 때 위젯 렌더링
            // if(snapshot.hasError) => 에러가 났을 때 위젯 렌더링
            // 로딩중일때 위젯 렌더링

            // FutureBuilder는 캐싱 기능이 있어 setState가 호출되어도 기존 데이터는 남아있음
            // 만일 ConnectionState.waiting일 때마다 로딩바를 띄우면 App 자체가 느린 것 같은 인상을 줌
            // 따라서, FutureBuilder의 캐싱 기능을 활용하여 로딩바를 띄워주는 것이 더 좋은 방법
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'future builder',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'ConState : ${snapshot.connectionState}', // done, waiting
                ),
                Text(
                  'data : ${snapshot.data}',
                ),
                Text(
                  'error : ${snapshot.error}',
                ),
                ElevatedButton(
                  onPressed: () {
                    // setState가 실행되면 build가 재실행되며, FutureBuilder가 재실행됨
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

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random();

    return random.nextInt(100);
  }
}
