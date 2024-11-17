import 'database.dart';

class DatabaseSingleton {
  static final DatabaseSingleton _shared = DatabaseSingleton._sharedInstance();

  DatabaseSingleton._sharedInstance();

  factory DatabaseSingleton() => _shared;

  final AppDatabase database = AppDatabase();
}
