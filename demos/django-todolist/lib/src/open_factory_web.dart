import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite_async.dart';

PowerSyncOpenFactory crateOpenFactory(String path, String key) {
  return _EncryptedOpenFactory(path: path, key: key);
}

class _EncryptedOpenFactory extends PowerSyncOpenFactory {
  _EncryptedOpenFactory({required super.path, required this.key});

  final String key;

  @override
  List<String> pragmaStatements(SqliteOpenOptions options) {
    final basePragmaStatements = super.pragmaStatements(options);
    return [
      // Set the encryption key as the first statement
      "PRAGMA KEY = ${quoteString(key)}",
      // Include the default statements afterwards
      for (var statement in basePragmaStatements) statement
    ];
  }
}
