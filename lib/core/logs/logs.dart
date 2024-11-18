import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal/core/logs/bloc_observer.dart';

void setUpLoging() {
  if (kDebugMode) {
    Bloc.observer = MyBlocObserver();
  }
}
