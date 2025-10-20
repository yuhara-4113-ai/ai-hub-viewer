import 'package:flutter/material.dart';
import '../models/ai_response.dart';
import '../services/gemini_service.dart';
import '../services/claude_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _questionController = TextEditingController();
  final GeminiService _geminiService = GeminiService();
  final ClaudeService _claudeService = ClaudeService();

  List<AiResponse> _responses = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _sendQuestion() async {
    final question = _questionController.text.trim();
    if (question.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('質問を入力してください')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _responses = [
        AiResponse(aiName: 'Gemini', isLoading: true),
        AiResponse(aiName: 'Claude', isLoading: true),
      ];
    });

    // Send questions to both APIs in parallel
    final results = await Future.wait([
      _getGeminiResponse(question),
      _getClaudeResponse(question),
    ]);

    setState(() {
      _responses = results;
      _isLoading = false;
    });
  }

  Future<AiResponse> _getGeminiResponse(String question) async {
    try {
      final response = await _geminiService.generateResponse(question);
      return AiResponse(aiName: 'Gemini', response: response);
    } catch (e) {
      return AiResponse(
        aiName: 'Gemini',
        error: 'エラー: ${e.toString()}',
      );
    }
  }

  Future<AiResponse> _getClaudeResponse(String question) async {
    try {
      final response = await _claudeService.generateResponse(question);
      return AiResponse(aiName: 'Claude', response: response);
    } catch (e) {
      return AiResponse(
        aiName: 'Claude',
        error: 'エラー: ${e.toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Hub Viewer'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _questionController,
                  decoration: const InputDecoration(
                    labelText: '質問を入力',
                    border: OutlineInputBorder(),
                    hintText: 'AIに質問してください...',
                  ),
                  maxLines: 3,
                  enabled: !_isLoading,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendQuestion,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            '送信',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _responses.isEmpty
                ? const Center(
                    child: Text(
                      '質問を入力して送信ボタンを押してください',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _responses.length,
                    itemBuilder: (context, index) {
                      final response = _responses[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.smart_toy,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    response.aiName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              if (response.isLoading)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              else if (response.error != null)
                                Text(
                                  response.error!,
                                  style: const TextStyle(color: Colors.red),
                                )
                              else
                                Text(
                                  response.response,
                                  style: const TextStyle(fontSize: 14),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
