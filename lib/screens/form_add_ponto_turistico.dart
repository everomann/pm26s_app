import 'package:flutter/material.dart';
import 'package:pm26s_app/data/ponto_turistico_DAO.dart';
import 'package:pm26s_app/widgets/ponto_turistico_card.dart';
import 'package:intl/intl.dart';

class FormAddPontoTuristico extends StatefulWidget {
  const FormAddPontoTuristico(
      {Key? key, required this.pontoTuristicoCardContext})
      : super(key: key);

  final BuildContext pontoTuristicoCardContext;

  @override
  State<FormAddPontoTuristico> createState() => _FormAddPontoTuristicoState();
}

class _FormAddPontoTuristicoState extends State<FormAddPontoTuristico> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _diferenciaisController = TextEditingController();
  final _imagemController = TextEditingController();
  final _dataCadastroController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Novo Ponto Turístico'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (valueValidator(value)) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  controller: _nomeController,
                  decoration: const InputDecoration(
                      labelText: 'Nome do Ponto Turístico'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (String? value) {
                    if (valueValidator(value)) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  controller: _descricaoController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (String? value) {
                    if (valueValidator(value)) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  controller: _diferenciaisController,
                  decoration: const InputDecoration(labelText: 'Diferenciais'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (valueValidator(value)) {
                      return 'Insira uma URL de Imagem';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.url,
                  controller: _imagemController,
                  decoration: const InputDecoration(labelText: 'URL Imagem'),
                ),
              ),
              Container(
                height: 240,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.blue)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(_imagemController.text, errorBuilder:
                      (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                    return Image.asset('assets/images/nophoto.png');
                  }, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (String? value) {
                    if (valueValidator(value)) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  controller: _dataCadastroController,
                  decoration: const InputDecoration(labelText: 'Data Cadastro'),
                  enabled: false,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await PontoTuristicoDao().save(PontoTuristico(
                          _nomeController.text,
                          _descricaoController.text,
                          _diferenciaisController.text,
                          _imagemController.text,
                          _dataCadastroController.text));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Ponto Turístico Salvo'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
