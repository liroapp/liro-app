import 'package:liro/data/app_exceptions/app_exceptions.dart';

class DataClass<T> {
  final T? data;
  final AppException? appexception;
  DataClass({this.data, this.appexception});
}