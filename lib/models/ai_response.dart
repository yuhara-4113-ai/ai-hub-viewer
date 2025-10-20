class AiResponse {
  final String aiName;
  final String response;
  final bool isLoading;
  final String? error;

  AiResponse({
    required this.aiName,
    this.response = '',
    this.isLoading = false,
    this.error,
  });

  AiResponse copyWith({
    String? aiName,
    String? response,
    bool? isLoading,
    String? error,
  }) {
    return AiResponse(
      aiName: aiName ?? this.aiName,
      response: response ?? this.response,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
