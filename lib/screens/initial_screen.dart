import 'package:flutter/material.dart';
import '../components/task.dart';
import '../data/task_dao.dart';
import 'form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          )
        ],
        title: const Text('Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 72),
        child: FutureBuilder<List<Task>>(
          future: taskDao().findAll(),
          builder: (context, snapshot) {
            List<Task>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando...'),
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
                      itemBuilder: (BuildContext context, index) {
                        final Task tarefa = items[index];
                        return tarefa;
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      children: const [
                        Icon(Icons.error_outline, size: 128),
                        Text(
                          'Não há nenhuma Tarefa',
                          style: TextStyle(fontSize: 32),
                        )
                      ],
                    ),
                  );
                }
                return const Text('Erro ao carregar Tarefas ');
            }
            // ignore: dead_code
            return const Text('Erro desconhecido');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          ).then((value) => setState(() {
                // ignore: avoid_print
                print('Recarregando a tela inicial');
              }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
