import 'package:flutter/material.dart';

class AgentInteractionScreen extends StatefulWidget {
  final String agentName;

  const AgentInteractionScreen({super.key, required this.agentName});

  @override
  State<AgentInteractionScreen> createState() => _AgentInteractionScreenState();
}

class _AgentInteractionScreenState extends State<AgentInteractionScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    // Initial greeting
    _messages.add({
      'role': 'ai',
      'text': 'Hello! I am your ${widget.agentName}. Tap the microphone to speak, or type below.'
    });
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': _controller.text});
      // Simulate AI thinking and response
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _messages.add({
              'role': 'ai',
              'text': 'I understand you want to "${_controller.text}". I am working on that for you. Is there anything specific you need to add?'
            });
          });
        }
      });
      _controller.clear();
    });
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });
    
    if (_isListening) {
       // Simulate voice input delay
       Future.delayed(const Duration(seconds: 2), () {
         if (mounted && _isListening) {
           setState(() {
             _isListening = false;
             _controller.text = "Help me organize my schedule";
           });
         }
       });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.agentName),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'What is this agent doing?',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Agent Status'),
                  content: const Text('This agent is currently waiting for your command. It has limited access and cannot delete your files.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isAi = msg['role'] == 'ai';
                return Align(
                  alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    constraints: const BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      color: isAi ? Colors.grey.shade200 : Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      msg['text']!,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isListening)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.red.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.mic, color: Colors.red, size: 30),
                  SizedBox(width: 10),
                  Text("Listening...", style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type here...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        ),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 12),
                    FloatingActionButton(
                      onPressed: _sendMessage,
                      elevation: 0,
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Big Voice Button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton.icon(
                    onPressed: _toggleListening,
                    icon: Icon(_isListening ? Icons.stop : Icons.mic, size: 28),
                    label: Text(_isListening ? 'Stop Listening' : 'Tap to Speak'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isListening ? Colors.red.shade100 : Theme.of(context).colorScheme.primary,
                      foregroundColor: _isListening ? Colors.red.shade900 : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
