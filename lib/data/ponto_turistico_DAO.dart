import 'package:pm26s_app/data/database.dart';
import 'package:pm26s_app/widgets/ponto_turistico_card.dart';
import 'package:sqflite/sqflite.dart';

class PontoTuristicoDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_nome TEXT, '
      '$_descricao TEXT, '
      '$_diferenciais TEXT, '
      '$_imagem TEXT)';
      //'$_dataCadastro TEXT)';

  static const String _tablename = 'pontoTuristicoTable';
  static const String _nome = 'nome';
  static const String _descricao = 'descricao';
  static const String _diferenciais = 'diferenciais';
  static const String _imagem = 'imagem';
  //static const String _dataCadastro = 'dataCadastro';

  save(PontoTuristico pontoTuristico) async {
    print('Iniciando o save: ');

    final Database bancoDeDados = await getDatabase();
    var itemExists = await findByNome(pontoTuristico.nome);
    Map<String, dynamic> pontoTuristicoMap = toMap(pontoTuristico);

    if (itemExists.isEmpty) {
      print('o ponto turistico n existia');

      return await bancoDeDados.insert(_tablename, pontoTuristicoMap);
    } else {
      print('o ponto turistico ja existia');
      return await bancoDeDados.update(_tablename, pontoTuristicoMap,
          where: '$_nome = ?', whereArgs: [pontoTuristico.nome]);
    }
  }

  Map<String, dynamic> toMap(PontoTuristico pontoTuristico) {
    print('convertendo tarefa em map: ');

    final Map<String, dynamic> mapaDePontosTuristicos = Map();
    mapaDePontosTuristicos[_nome] = pontoTuristico.nome;
    mapaDePontosTuristicos[_descricao] = pontoTuristico.descricao;
    mapaDePontosTuristicos[_diferenciais] = pontoTuristico.diferenciais;
    mapaDePontosTuristicos[_imagem] = pontoTuristico.imagem;
    //mapaDePontosTuristicos[_dataCadastro] = pontoTuristico.dataCadastro;
    print('mapa de tarefas: $mapaDePontosTuristicos');

    return mapaDePontosTuristicos;
  }

  Future<List<PontoTuristico>> findAll() async {
    print('acessando findall: ');

    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('dados encontrados: $result');
    return toList(result);
  }

  List<PontoTuristico> toList(
      List<Map<String, dynamic>> mapaDePontosTuristicos) {
    print('convertendo to list: ');
    final List<PontoTuristico> pontosTuristicos = [];

    for (Map<String, dynamic> linha in mapaDePontosTuristicos) {
      final PontoTuristico pontoTuristico = PontoTuristico(linha[_nome],
          linha[_descricao], linha[_diferenciais], linha[_imagem]);
      pontosTuristicos.add(pontoTuristico);
    }

    print('pontos turisticos $pontosTuristicos');

    return pontosTuristicos;
  }

  Future<List<PontoTuristico>> findByNome(String nomePontoTuristico) async {
    print('acessando find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_nome = ?',
      whereArgs: [nomePontoTuristico],
    );
    print('ponto turistico encontrado: ${toList(result)}');
    return toList(result);
  }

  delete(String nomePontoTuristico) async {
    print('deletando ponto turistico: $nomePontoTuristico');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      _tablename,
      where: '$_nome = ?',
      whereArgs: [nomePontoTuristico],
    );
  }

  Future<PontoTuristico?> get(String nomePontoTuristico) async {
    final List<PontoTuristico> pontosTuristicos = await findByNome(nomePontoTuristico);
    if (pontosTuristicos.isNotEmpty) {
      return pontosTuristicos.first;
    }
    return null;
  }


}
