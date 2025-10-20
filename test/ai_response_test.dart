import 'package:flutter_test/flutter_test.dart';
import 'package:ai_hub_viewer/models/ai_response.dart';

void main() {
  group('AiResponse Model Tests', () {
    test('AiResponse should be created with correct initial values', () {
      final response = AiResponse(
        aiName: 'TestAI',
        response: 'Test response',
        isLoading: false,
        error: null,
      );

      expect(response.aiName, 'TestAI');
      expect(response.response, 'Test response');
      expect(response.isLoading, false);
      expect(response.error, null);
    });

    test('AiResponse copyWith should create a new instance with updated values', () {
      final original = AiResponse(
        aiName: 'TestAI',
        response: 'Original',
        isLoading: true,
      );

      final updated = original.copyWith(
        response: 'Updated',
        isLoading: false,
      );

      expect(updated.aiName, 'TestAI');
      expect(updated.response, 'Updated');
      expect(updated.isLoading, false);
    });

    test('AiResponse should handle error state', () {
      final response = AiResponse(
        aiName: 'TestAI',
        error: 'Test error',
      );

      expect(response.error, 'Test error');
      expect(response.response, '');
    });

    test('AiResponse should handle loading state', () {
      final response = AiResponse(
        aiName: 'TestAI',
        isLoading: true,
      );

      expect(response.isLoading, true);
      expect(response.response, '');
      expect(response.error, null);
    });
  });
}
