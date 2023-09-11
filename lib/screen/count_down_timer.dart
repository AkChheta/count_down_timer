import 'dart:async';

import 'package:count_down_timer/model/count_down_timer_model.dart';
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  //
  // CountDownTimer List
  //
  List<CountDownTimerModel> countDownTimerList = [];
  //
  // Start Timer
  //
  void _startTimer(int index) {
    int duration = int.tryParse(countDownTimerList[index].seconds.text) ?? 0;
    if (duration <= 0) {
      return;
    }
    if (countDownTimerList[index].isRunning == true) {
      countDownTimerList[index].timer.cancel();
      setState(() {
        countDownTimerList[index].isRunning = false;
      });
    } else {
      if (countDownTimerList[index].currentTime <= 0) {
        countDownTimerList[index].currentTime = duration;
      }
      countDownTimerList[index].timer =
          Timer.periodic(const Duration(seconds: 1), (timer) {
        if (countDownTimerList[index].currentTime > 0) {
          setState(() {
            countDownTimerList[index].currentTime--;
          });
        } else {
          countDownTimerList[index].timer.cancel();
          setState(() {
            countDownTimerList[index].isRunning = null;
          });
        }
      });
      setState(() {
        countDownTimerList[index].isRunning = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE7D8FF),
        title: const Text('Count Down Timer',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: countDownTimerList.isEmpty
          ? const Center(
              child: Text('Add Count Down Timer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            )
          : ListView.builder(
              itemCount: countDownTimerList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 110),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 120,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 5)),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              controller: countDownTimerList[index].seconds,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 5)),
                        child: Text(
                          // ignore: unnecessary_string_interpolations
                          '${Duration(seconds: countDownTimerList[index].currentTime).toString().split('.').first}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _startTimer(index);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 120,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 5)),
                          child: Text(
                            // ignore: unrelated_type_equality_checks
                            countDownTimerList[index].currentTime == '0:00:00'
                                ? 'Start'
                                : countDownTimerList[index].isRunning == null
                                    ? 'Start'
                                    : countDownTimerList[index].isRunning ==
                                            true
                                        ? 'Pasue'
                                        : 'Resume',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var timer = CountDownTimerModel(
              seconds: TextEditingController(),
              currentTime: 0,
              timer: Timer(Duration.zero, () {}),
              isRunning: null);
          countDownTimerList.add(timer);
          setState(() {});
        },
        child: const Text("Add"),
      ),
    );
  }
}
