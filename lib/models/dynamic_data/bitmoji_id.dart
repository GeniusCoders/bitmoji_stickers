import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@lazySingleton
class BitmojiIdData {
  BehaviorSubject<String> _id = BehaviorSubject<String>.seeded('%s');

  Stream get bitmojiId$ => _id.stream;

  String get bitmojiIdValue => _id.value;

  addBitmojiId({required String id}) {
    _id.add(id);
  }
}
