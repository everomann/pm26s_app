import 'package:flutter/material.dart';
import 'package:pm26s_app/data/ponto_turistico_DAO.dart';
import 'package:pm26s_app/screens/form_add_ponto_turistico.dart';
import 'package:pm26s_app/widgets/ponto_turistico_card.dart';
import 'package:pm26s_app/widgets/filtro.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  String _searchQuery = '';
  PontoTuristico? _selectedPontoTuristico;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pontos Turísticos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PontoTuristicoDelegate(
                  (query) => setState(() => _searchQuery = query),
                  (pontoTuristico) =>
                      setState(() => _selectedPontoTuristico = pontoTuristico),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<PontoTuristico>>(
            future: PontoTuristicoDao().findAll(),
            builder: (context, snapshot) {
              List<PontoTuristico>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregand...'),
                      ],
                    ),
                  );
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregando...'),
                      ],
                    ),
                  );
                case ConnectionState.active:
                  return Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        Text('Carregando...'),
                      ],
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final PontoTuristico pontoTuristico = items[index];
                            return pontoTuristico;
                          });
                    }

                    return Center(
                      child: Column(
                        children: const [
                          Icon(Icons.error_outline, size: 128),
                          Text(
                            'Nenhum Ponto Turístico.',
                            style: TextStyle(fontSize: 32),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Text('Erro ao carregar Pontos Turísticos.');
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormAddPontoTuristico(
                pontoTuristicoCardContext: context,
              ),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
