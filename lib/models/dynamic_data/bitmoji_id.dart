import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@lazySingleton
class BitmojiIdData {
  BehaviorSubject<String> _id =
      BehaviorSubject<String>.seeded('12430618-b508-4d2e-b2c8-17eaf61217b2');

  Stream get bitmojiId$ => _id.stream;

  String get bitmojiIdValue => _id.value;

  addBitmojiId({String id}) {
    _id.add(id);
  }
}
