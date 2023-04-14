import 'package:flutter/material.dart';
import 'package:pm26s_app/data/ponto_turistico_DAO.dart';
import 'package:pm26s_app/screens/form_add_ponto_turistico.dart';

class PontoTuristicoPage extends StatefulWidget {
  const PontoTuristicoPage({Key? key, required this.pontoTuristicoPageContext})
      : super(key: key);

  final BuildContext pontoTuristicoPageContext;

  @override
  State<PontoTuristicoPage> createState() => _PontoTuristicoPageState();
}

class _PontoTuristicoPageState extends State<PontoTuristicoPage> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final nome = arguments['nome'];
    final descricao = arguments['descricao'];
    final diferenciais = arguments['diferenciais'];
    final imagem = arguments['imagem'];
    final dataCadastro = arguments['dataCadastro'];

    return Scaffold(
      appBar: AppBar(
        title: Text(nome),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                        'Tem certeza que deseja excluir este Ponto Turístico?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () {
                          PontoTuristicoDao().delete(nome);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Ponto Turístico excluído'),
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Confirmar",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 70),
          child: Column(
            children: [
              Container(
                height: 240,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(imagem, errorBuilder:
                      (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                    return Image.asset('assets/images/nophoto.png');
                  }, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        descricao,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Diferenciais',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        diferenciais,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Data Cadastro',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        dataCadastro,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormAddPontoTuristico(
                pontoTuristicoCardContext: contextNew,
              ),
              settings: RouteSettings(
                arguments: {
                  // 'nome': widget.nome,
                  'descricao': descricao,
                  'diferenciais': diferenciais,
                  'imagem': imagem,
                  'dataCadastro': dataCadastro,
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
