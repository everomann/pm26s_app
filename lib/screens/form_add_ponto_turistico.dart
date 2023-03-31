import 'package:flutter/material.dart';

class FormAddPontoTuristico extends StatefulWidget {
  const FormAddPontoTuristico({Key? key}) : super(key: key);

  @override
  State<FormAddPontoTuristico> createState() => _FormAddPontoTuristicoState();
}

class _FormAddPontoTuristicoState extends State<FormAddPontoTuristico> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _diferenciaisController = TextEditingController();
  final _imagemController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  controller: _nomeController,
                  decoration:
                      InputDecoration(labelText: 'Nome do Ponto Turístico'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  controller: _descricaoController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  controller: _diferenciaisController,
                  decoration: InputDecoration(labelText: 'Diferenciais'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira um URL de Imagem';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.url,
                  controller: _imagemController,
                  decoration: InputDecoration(labelText: 'URL Imagem'),
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
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //Navigator.pop(context);
                      print(_nomeController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ponto Turístico Salvo'),
                        ),
                      );
                    }
                  },
                  child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------
//
// class _NovoPontoTuristicoState extends State<NovoPontoTuristico> {
//   final _formKey = GlobalKey<FormState>();
//   final _nomeController = TextEditingController();
//   final _descricaoController = TextEditingController();
//   final _diferenciaisController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Novo Ponto Turístico'),
//         ),
//         body: Padding(
//         padding: const EdgeInsets.all(16.0),
//     child: Form(
//     key: _formKey,
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     TextFormField(
//     controller: _nomeController,
//     decoration: InputDecoration(
//     labelText: 'Nome do Ponto Turístico',
//     ),
//     validator: (value) {
//     if (value.isEmpty) {
//     return 'Campo obrigatório';
//     }
//     return null;
//     },
//     ),
//     SizedBox(height: 16.0),
//     TextFormField(
//     controller: _descricaoController,
//     maxLines: 3,
//     decoration: InputDecoration(
//     labelText: 'Descrição',
//     ),
//     validator: (value) {
//     if (value.isEmpty) {
//     return 'Campo obrigatório';
//     }
//     return null;
//     },
//     ),
//     SizedBox(height: 16.0),
//     TextFormField(
//     controller: _diferenciaisController,
//     decoration: InputDecoration(
//     labelText: 'Diferenciais',
//     ),
//     ),
//     SizedBox(height: 16.0),
//     ElevatedButton(
//     onPressed: () {
//     if (_formKey.currentState.validate()) {
//     // TODO: salvar os dados do ponto turístico
//     Navigator.pop(context);
//     }
//     },
//     child: Text('Salvar'),
