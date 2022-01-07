import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/group/clients/pending_requests_remote_client.dart';

final pendingRequestProvider =
    Provider((ref) => PendingRequestProvider(ref.read));

class PendingRequestProvider {
  final Reader _reader;

  PendingRequestProvider(this._reader) : super();

  fetchMyPendingRequests() {
    return _reader(pendingRequestsClientProvider).fetchMyPendingRequests();
  }
}
