import 'package:assignment_4_cst407/models/database_connection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = StateProvider((ref) => DatabaseConnection());
