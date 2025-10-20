# アーキテクチャドキュメント / Architecture Document

## プロジェクト構造

```
ai-hub-viewer/
├── lib/
│   ├── main.dart                 # アプリケーションのエントリーポイント
│   ├── models/
│   │   └── ai_response.dart      # AIレスポンスのデータモデル
│   ├── screens/
│   │   └── home_screen.dart      # メイン画面のUI
│   └── services/
│       ├── gemini_service.dart   # Gemini API統合
│       └── claude_service.dart   # Claude API統合
├── test/
│   ├── ai_response_test.dart     # モデルのユニットテスト
│   └── widget_test.dart          # ウィジェットテスト
├── .env                          # 環境変数（APIキー）
├── .env.example                  # 環境変数のテンプレート
├── pubspec.yaml                  # 依存関係の定義
└── analysis_options.yaml         # Linterの設定
```

## レイヤーアーキテクチャ

### 1. Presentation Layer（プレゼンテーション層）

#### `lib/main.dart`
- アプリケーションの初期化
- 環境変数の読み込み
- MaterialAppの設定
- テーマの定義

#### `lib/screens/home_screen.dart`
- ユーザーインターフェース
- 状態管理（StatefulWidget）
- ユーザー入力の処理
- AIレスポンスの表示

**主要な機能:**
- `_sendQuestion()`: 質問を両方のAPIに送信
- `_getGeminiResponse()`: Gemini APIからレスポンスを取得
- `_getClaudeResponse()`: Claude APIからレスポンスを取得

### 2. Service Layer（サービス層）

#### `lib/services/gemini_service.dart`
- Gemini APIとの通信
- HTTPリクエストの構築
- レスポンスのパース
- エラーハンドリング

**エンドポイント:**
```
https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent
```

**リクエスト形式:**
```json
{
  "contents": [
    {
      "parts": [
        {"text": "質問テキスト"}
      ]
    }
  ]
}
```

#### `lib/services/claude_service.dart`
- Claude APIとの通信
- HTTPリクエストの構築
- レスポンスのパース
- エラーハンドリング

**エンドポイント:**
```
https://api.anthropic.com/v1/messages
```

**リクエスト形式:**
```json
{
  "model": "claude-3-haiku-20240307",
  "max_tokens": 1024,
  "messages": [
    {
      "role": "user",
      "content": "質問テキスト"
    }
  ]
}
```

### 3. Model Layer（モデル層）

#### `lib/models/ai_response.dart`
- AIレスポンスのデータ構造
- イミュータブルなデータモデル
- `copyWith()` メソッドによる更新

**プロパティ:**
- `aiName`: AI の名前（"Gemini" or "Claude"）
- `response`: AIからの回答テキスト
- `isLoading`: ローディング状態
- `error`: エラーメッセージ（あれば）

## データフロー

```
1. ユーザー入力
   ↓
2. HomeScreen (_sendQuestion)
   ↓
3. 並列実行: Future.wait([
     _getGeminiResponse(),
     _getClaudeResponse()
   ])
   ↓
4. Service Layer
   ├─ GeminiService.generateResponse()
   └─ ClaudeService.generateResponse()
   ↓
5. HTTP リクエスト
   ↓
6. API レスポンス
   ↓
7. レスポンスのパース
   ↓
8. AiResponse モデルの作成
   ↓
9. UIの更新 (setState)
   ↓
10. ユーザーに結果を表示
```

## 状態管理

現在の実装では、シンプルな `StatefulWidget` による状態管理を使用しています。

### 状態変数
```dart
List<AiResponse> _responses = [];  // AIレスポンスのリスト
bool _isLoading = false;            // ローディング状態
```

### 状態の更新
```dart
setState(() {
  _isLoading = true;
  _responses = [初期状態のレスポンス];
});

// API呼び出し後

setState(() {
  _responses = [新しいレスポンス];
  _isLoading = false;
});
```

## エラーハンドリング

### 3層のエラーハンドリング

1. **Service Layer**
   - HTTPエラーをキャッチ
   - Exceptionとして投げる

2. **Screen Layer**
   - try-catchでエラーをキャッチ
   - AiResponseにエラーメッセージを設定

3. **UI Layer**
   - エラー状態を視覚的に表示
   - 赤いテキストでエラーメッセージを表示

### エラーの種類

1. **環境変数エラー**
   ```
   Exception: GEMINI_API_KEY not found in .env file
   ```

2. **APIエラー**
   ```
   Exception: Failed to get response from Gemini: 401 Unauthorized
   ```

3. **ネットワークエラー**
   - HTTPライブラリが自動的に処理

## 依存関係

### Production Dependencies

#### `flutter`
- フレームワーク本体

#### `http: ^1.1.0`
- HTTP リクエスト用
- RESTful API通信に使用

#### `flutter_dotenv: ^5.1.0`
- 環境変数の管理
- APIキーの安全な保存

### Development Dependencies

#### `flutter_test`
- ユニットテストとウィジェットテスト

#### `flutter_lints: ^3.0.0`
- コード品質チェック
- ベストプラクティスの適用

## セキュリティ考慮事項

### APIキーの保護
1. `.env` ファイルに保存
2. `.gitignore` に含める
3. コードに直接書かない

### HTTPS通信
- すべてのAPI通信はHTTPSを使用
- 中間者攻撃からの保護

### 入力検証
- 質問が空でないことを確認
- トリムして空白を除去

## パフォーマンス最適化

### 並列処理
- `Future.wait()` を使用して両方のAPIに同時にリクエスト
- 一方が遅くても影響を最小化

### UIの最適化
- `const` コンストラクタの使用
- 不要な再ビルドを避ける

### メモリ管理
- `dispose()` でTextEditingControllerを適切に破棄

## 拡張性

### 新しいAIプロバイダーの追加

1. 新しいServiceクラスを作成
   ```dart
   class NewAiService {
     Future<String> generateResponse(String question) async {
       // 実装
     }
   }
   ```

2. HomeScreenに統合
   ```dart
   final results = await Future.wait([
     _getGeminiResponse(question),
     _getClaudeResponse(question),
     _getNewAiResponse(question),
   ]);
   ```

### インターフェースの抽出（将来的な改善）

```dart
abstract class AiService {
  Future<String> generateResponse(String question);
}

class GeminiService implements AiService { ... }
class ClaudeService implements AiService { ... }
```

## テスト戦略

### ユニットテスト
- `test/ai_response_test.dart`
- モデルの動作を検証

### ウィジェットテスト
- `test/widget_test.dart`
- UI コンポーネントの動作を検証

### 統合テスト（今後）
- エンドツーエンドのフロー検証
- 実際のAPIとの統合テスト（モック使用）

## 今後の改善点

### アーキテクチャ
- [ ] BLoC または Provider による状態管理
- [ ] Repository パターンの導入
- [ ] 依存性注入（Dependency Injection）

### 機能
- [ ] オフラインキャッシュ
- [ ] 回答の履歴管理
- [ ] ユーザー設定の永続化

### テスト
- [ ] カバレッジ80%以上
- [ ] E2Eテストの追加
- [ ] モックサーバーを使用した統合テスト
