part of 'internetcubit_cubit.dart';

@immutable
abstract class InternetcubitState {}

class InternetcubitInitial extends InternetcubitState {}

class InternetConnected extends InternetcubitState {}

class InternetDisconnected extends InternetcubitState {}
