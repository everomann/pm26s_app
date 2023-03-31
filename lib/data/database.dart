import 'package:pm26s_app/data/ponto_turistico_DAO.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'ponto_turistico.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(PontoTuristicoDao.tableSql);
  }, version: 1,);
}

