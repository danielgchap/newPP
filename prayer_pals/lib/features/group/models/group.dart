import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  factory Group({
    required String groupUID,
    required String groupName,
    String? description,
    String? creatorUID,
    bool? isPrivate,
    String? tags,
    String? imageURL,
    List<String>? searchParamsList,
  }) = _Group;
  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
