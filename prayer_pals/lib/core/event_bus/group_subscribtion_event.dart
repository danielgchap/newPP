import 'package:prayer_pals/features/group/models/group.dart';

class SubscribeToGroupPNEvent {
  final Group group;
  SubscribeToGroupPNEvent({required this.group});
}

class UNSubscribeToGroupPNEvent {
  final Group group;
  UNSubscribeToGroupPNEvent({required this.group});
}
