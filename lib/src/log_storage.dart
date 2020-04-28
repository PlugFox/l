import 'log_storage/log_storage_base.dart';
import 'log_storage/log_storage_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'log_storage/log_storage_html.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'log_storage/log_storage_io.dart';

export 'log_storage/log_storage_base.dart';

///
LogStorage get logStorage => getLogStorage();
