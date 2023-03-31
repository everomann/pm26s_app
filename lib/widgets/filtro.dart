import 'package:flutter/material.dart';
import 'package:pm26s_app/data/ponto_turistico_DAO.dart';
import 'package:pm26s_app/widgets/ponto_turistico_card.dart';

class PontoTuristicoDelegate extends SearchDelegate<PontoTuristico?> {
  final Function(String) onQueryChanged;
  final Function(PontoTuristico) onPontoTuristicoSelected;

  PontoTuristicoDelegate(this.onQueryChanged, this.onPontoTuristicoSelected);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onQueryChanged('');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder<List<PontoTuristico>>(
      future: PontoTuristicoDao().findByNome(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao buscar pontos turísticos.'));
        }

        final pontosTuristicos = snapshot.data ?? [];

        if (pontosTuristicos.isEmpty) {
          return const Center(
              child: Text('Nenhum ponto turístico encontrado.'));
        }

        return ListView.builder(
          itemCount: pontosTuristicos.length,
          itemBuilder: (BuildContext context, int index) {
            final pontoTuristico = pontosTuristicos[index];
            return ListTile(
              title: Text(pontoTuristico.nome,
              style: TextStyle(fontSize: 18),),
              onTap: () {
                onPontoTuristicoSelected(pontoTuristico);
                close(context, pontoTuristico);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
