import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RequestState { loading, error, success }

abstract class BasePageState<T extends StatefulWidget> extends State<T> {
  RequestState requestState = RequestState.loading;
  String title = 'Title';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(child: _showCurrentState()));
  }

  Widget _showCurrentState() {
    switch(requestState) {
      case RequestState.loading:
        return onLoading();
      case RequestState.success:
        return onSuccess();
      case RequestState.error:
      default:
        return onError();
    }
  }

  Widget onLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget onError() {
    return Center(child: Text('Something went wrong, try again later.'));
  }

  Widget onSuccess();
}
