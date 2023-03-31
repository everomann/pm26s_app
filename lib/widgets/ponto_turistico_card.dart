import 'package:flutter/material.dart';
import 'package:pm26s_app/screens/ponto_turistico_page.dart';

class PontoTuristico extends StatefulWidget {
  final String nome;
  final String descricao;
  final String diferenciais;
  final String imagem;
  //final String dataCadastro;

  const PontoTuristico(
      this.nome, this.descricao, this.diferenciais, this.imagem,
      {Key? key})
      : super(key: key);

  @override
  State<PontoTuristico> createState() => _PontoTuristicoState();
}

class _PontoTuristicoState extends State<PontoTuristico> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (contextNew) => PontoTuristicoPage(
              pontoTuristicoPageContext: context,
            ),
            settings: RouteSettings(
              arguments: {
                'nome': widget.nome,
                'descricao': widget.descricao,
                'diferenciais': widget.diferenciais,
                'imagem': widget.imagem,
              },
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              height: 180,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5.0,
                    offset: const Offset(0, 3),
                  )
                ],
                image: DecorationImage(
                  image: NetworkImage(widget.imagem),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 75,
                    width: 400,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(8.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.nome,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          widget.descricao,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
