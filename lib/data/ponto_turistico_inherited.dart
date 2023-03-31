import 'package:flutter/material.dart';
import 'package:pm26s_app/widgets/ponto_turistico_card.dart';

class PontoTuristicoInherited extends InheritedWidget {
  PontoTuristicoInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<PontoTuristico> pontoTuristicoList = [
    const PontoTuristico('Paróquia São Pedro', 'Igreja Matriz Paróquia São Pedro Apóstolo', 'Wi-fi publico', 'https://franciscanos.org.br/quemsomos/wp-content/uploads/2018/10/patobranco_261018-1.jpg')
  ];

  void  novoPontoTuristico(String nome, String descricao, String diferenciais, String imagem, String dataCadastro){
     pontoTuristicoList.add(PontoTuristico(nome, descricao, diferenciais, imagem ));

  }


  static PontoTuristicoInherited of(BuildContext context) {
    final PontoTuristicoInherited? result =
        context.dependOnInheritedWidgetOfExactType<PontoTuristicoInherited>();
    assert(result != null, 'No  found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PontoTuristicoInherited oldWidget) {
    return oldWidget.pontoTuristicoList.length != pontoTuristicoList.length;
  }
}
