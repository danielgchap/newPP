import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'prayer.freezed.dart';
part 'prayer.g.dart';

@freezed
class Prayer with _$Prayer {
  factory Prayer({
    required String uid,
    required String title,
    required String description,
    required String creatorUID,
    required String creatorDisplayName,
    required String? creatorImageURL,
    required String dateCreated,
    required bool isGlobal,
    required List<String> groups,
  }) = _Prayer;
  factory Prayer.fromJson(Map<String, dynamic> json) => _$PrayerFromJson(json);

  factory Prayer.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Prayer.fromJson(data).copyWith(uid: doc.id);
  }
}
