import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../models/firebase_file.dart';

class FirebaseStorageService {
  final _productsRef = FirebaseStorage.instance.ref('Products/');

  Future<List<String>> _getDownloadUrls(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  Future<List<FirebaseFile>> listAll(String wid) async {
    final ref = _productsRef.child('$wid/');
    final result = await ref.listAll();

    final urls = await _getDownloadUrls(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final name = result.items[index].name;
          final file = FirebaseFile(name: name, url: url);
          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static UploadTask? uploadImage(String wid, String pid, File file) {
    try {
      final ref = FirebaseStorage.instance.ref('Products/$wid/$pid');
      return ref.putFile(file);
    } on FirebaseException catch (_) {
      return null;
    }
  }
}
