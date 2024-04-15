import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController controlador = TextEditingController();
  final TextEditingController controladorEditar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFE6E7E8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEF992D),
          title: const Text('Lista de Afazeres', style: TextStyle(color: Colors.white)),
          
        ),
        bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF3A5C33),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controlador,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Descrição',
                    hintStyle: TextStyle(color: Color.fromARGB(176, 255, 255, 255)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(200, 60)),
                ),
                child: const Text('Adicionar Tarefa', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  if (controlador.text.isEmpty) {
                    return;
                  }
                  setState(() {
                    _tarefas.add(
                      Tarefa(
                        descricao: controlador.text,
                        status: false,
                      ),
                    );
                    controlador.clear();
                  });
                },
              ),
            ),
          ],
        ),
      ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tarefas[index].descricao),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Color.fromARGB(255, 255, 203, 140),
                                  title: const Text('Editar Descrição:', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                                  content: TextField(
                                    controller: controladorEditar,
                                    decoration: InputDecoration(
                                      hintText: _tarefas[index].descricao,
                                      hintStyle: const TextStyle(color: Color.fromARGB(137, 0, 0, 0)),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            if (controladorEditar.text.trim().isEmpty) {
                                              return;
                                            }
                                            setState(() {
                                              _tarefas[index].descricao = controladorEditar.text;
                                              controladorEditar.clear();
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('Salvar'),
                                        )
                                      ]
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _tarefas.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tarefa {
  String descricao;
  bool status;

  Tarefa({required this.descricao, required this.status});
}