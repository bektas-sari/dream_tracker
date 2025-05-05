import 'package:flutter/material.dart';

void main() {
  runApp(const DreamTrackerApp());
}

class DreamTrackerApp extends StatelessWidget {
  const DreamTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dream Tracker',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const DreamTrackerHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DreamEntry {
  final String description;
  final DateTime date;

  DreamEntry({required this.description, required this.date});
}

class DreamTrackerHome extends StatefulWidget {
  const DreamTrackerHome({super.key});

  @override
  State<DreamTrackerHome> createState() => _DreamTrackerHomeState();
}

class _DreamTrackerHomeState extends State<DreamTrackerHome> {
  final List<DreamEntry> dreams = [];

  final TextEditingController _controller = TextEditingController();

  void _addDream() {
    if (_controller.text.isEmpty) return;
    setState(() {
      dreams.insert(
        0,
        DreamEntry(
          description: _controller.text,
          date: DateTime.now(),
        ),
      );
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dream Tracker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'What did you dream?',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _addDream,
              icon: const Icon(Icons.add),
              label: const Text('Save Dream'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: dreams.length,
                itemBuilder: (context, index) {
                  final dream = dreams[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.nightlight_round),
                      title: Text(dream.description),
                      subtitle: Text(
                        '${dream.date.day}/${dream.date.month}/${dream.date.year}',
                      ),
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
