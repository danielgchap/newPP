import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'ppcuser.freezed.dart';
part 'ppcuser.g.dart';

@freezed
class PPCUser with _$PPCUser {
  factory PPCUser(
      {required String username,
      required String emailAddress,
      required String uid,
      required String dateJoined,
      required int daysPrayedWeek,
      required int hoursPrayer,
      required int daysPrayedMonth,
      required int daysPrayedYear,
      required int daysPrayedLastYear,
      required bool removedAds,
      required int supportLevel,
      String? imageURL,
      String? phoneNumber,
      int? answered,
      int? prayers}) = _PPCUser;

  factory PPCUser.fromJson(Map<String, dynamic> json) =>
      _$PPCUserFromJson(json);
}
