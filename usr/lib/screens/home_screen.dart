import 'package:flutter/material.dart';
import 'package:couldai_user_app/widgets/action_card.dart';
import 'package:couldai_user_app/screens/agent_interaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My AI Helper'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What do you need help with?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tap a card below to start.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                  children: [
                    ActionCard(
                      title: 'Ask a Question',
                      icon: Icons.help_outline,
                      color: Colors.blue.shade100,
                      iconColor: Colors.blue.shade800,
                      onTap: () => _navigateToAgent(context, 'General Assistant'),
                    ),
                    ActionCard(
                      title: 'Write for Me',
                      icon: Icons.edit_note,
                      color: Colors.orange.shade100,
                      iconColor: Colors.orange.shade800,
                      onTap: () => _navigateToAgent(context, 'Writing Helper'),
                    ),
                    ActionCard(
                      title: 'Plan My Day',
                      icon: Icons.calendar_today,
                      color: Colors.green.shade100,
                      iconColor: Colors.green.shade800,
                      onTap: () => _navigateToAgent(context, 'Daily Planner'),
                    ),
                    ActionCard(
                      title: 'Fix a Problem',
                      icon: Icons.build,
                      color: Colors.purple.shade100,
                      iconColor: Colors.purple.shade800,
                      onTap: () => _navigateToAgent(context, 'Troubleshooter'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Emergency Stop / Help Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // In a real app, this would pause all active agents
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All AI activities paused.')),
                    );
                  },
                  icon: const Icon(Icons.stop_circle_outlined, size: 32),
                  label: const Text('STOP ALL AI'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade100,
                    foregroundColor: Colors.red.shade900,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAgent(BuildContext context, String agentName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgentInteractionScreen(agentName: agentName),
      ),
    );
  }
}
