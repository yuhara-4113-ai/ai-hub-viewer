# 貢献ガイド / Contributing Guide

AI Hub Viewerプロジェクトへの貢献に興味を持っていただきありがとうございます！

## 開発環境のセットアップ

### 必要なもの
- Flutter SDK 3.0.0以上
- Dart SDK 3.0.0以上
- Git
- お好みのエディタ（VS Code、Android Studio推奨）

### セットアップ手順

1. リポジトリをフォーク

2. ローカルにクローン
```bash
git clone https://github.com/YOUR_USERNAME/ai-hub-viewer.git
cd ai-hub-viewer
```

3. 依存関係をインストール
```bash
flutter pub get
```

4. `.env` ファイルをセットアップ
```bash
cp .env.example .env
# .envファイルにAPIキーを設定
```

5. 動作確認
```bash
flutter run
```

## コーディング規約

### Dartスタイルガイド
- [Effective Dart](https://dart.dev/guides/language/effective-dart) に従う
- `flutter_lints` パッケージの推奨事項に従う
- `flutter analyze` でエラーが出ないこと

### コード品質チェック

コミット前に必ず実行：

```bash
# コード解析
flutter analyze

# フォーマット
dart format .

# テスト
flutter test
```

### 命名規則

#### ファイル名
- すべて小文字
- 単語はアンダースコアで区切る
- 例: `gemini_service.dart`, `home_screen.dart`

#### クラス名
- PascalCase（各単語の最初を大文字）
- 例: `GeminiService`, `HomeScreen`, `AiResponse`

#### 変数名・関数名
- camelCase（最初の単語は小文字、以降は大文字）
- 例: `generateResponse`, `isLoading`, `questionController`

#### プライベートメンバー
- アンダースコアで始める
- 例: `_sendQuestion`, `_responses`, `_isLoading`

#### 定数
- lowerCamelCase（Dartの慣例）
- static const の場合は lowerCamelCase
- 例: `static const String baseUrl`

### コメント

#### ドキュメントコメント
```dart
/// Generates a response from the Gemini API.
///
/// Takes a [question] string and returns the AI-generated response.
/// Throws an [Exception] if the API key is not found or the request fails.
Future<String> generateResponse(String question) async {
  // 実装
}
```

#### 通常のコメント
```dart
// 質問を両方のAPIに並列送信
final results = await Future.wait([
  _getGeminiResponse(question),
  _getClaudeResponse(question),
]);
```

## ブランチ戦略

### ブランチ命名規則
- `feature/機能名` - 新機能
- `fix/バグ名` - バグ修正
- `docs/ドキュメント名` - ドキュメント更新
- `refactor/リファクタリング内容` - リファクタリング

例:
```bash
git checkout -b feature/add-history-feature
git checkout -b fix/api-timeout-error
git checkout -b docs/update-setup-guide
```

## プルリクエスト

### PRを作成する前に

1. **コードが動作することを確認**
```bash
flutter run
```

2. **すべてのテストをパス**
```bash
flutter test
```

3. **コード解析をパス**
```bash
flutter analyze
```

4. **コードフォーマット**
```bash
dart format .
```

### PRの説明

PRには以下の情報を含めてください：

```markdown
## 概要
このPRが解決する問題や追加する機能の説明

## 変更内容
- 変更点1
- 変更点2
- 変更点3

## テスト
実施したテストの概要

## スクリーンショット（UI変更の場合）
変更前後のスクリーンショット

## チェックリスト
- [ ] コードは動作する
- [ ] テストを追加した
- [ ] ドキュメントを更新した
- [ ] flutter analyzeをパスした
- [ ] 既存のテストがすべてパスする
```

## テスト

### ユニットテスト

新しいモデルやサービスクラスには必ずユニットテストを追加：

```dart
// test/services/new_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_hub_viewer/services/new_service.dart';

void main() {
  group('NewService', () {
    test('should return expected result', () {
      // Arrange
      final service = NewService();
      
      // Act
      final result = service.doSomething();
      
      // Assert
      expect(result, expectedValue);
    });
  });
}
```

### ウィジェットテスト

UI変更には対応するウィジェットテストを追加：

```dart
// test/screens/new_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_hub_viewer/screens/new_screen.dart';

void main() {
  testWidgets('NewScreen should display expected widgets', 
    (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: NewScreen()),
    );
    
    expect(find.text('Expected Text'), findsOneWidget);
  });
}
```

### テストカバレッジ

カバレッジレポートの生成：
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html  # macOS
```

目標: 80%以上のカバレッジ

## コミットメッセージ

### フォーマット
```
type: 簡潔な説明（50文字以内）

詳細な説明（必要な場合）
- 変更点1
- 変更点2
```

### タイプ
- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメントのみの変更
- `style`: コードの意味に影響しない変更（空白、フォーマットなど）
- `refactor`: バグ修正も機能追加もしないコード変更
- `test`: テストの追加や修正
- `chore`: ビルドプロセスやツールの変更

### 例
```bash
git commit -m "feat: add response history feature"
git commit -m "fix: handle API timeout errors properly"
git commit -m "docs: update setup guide with troubleshooting section"
git commit -m "refactor: extract common API logic to base service"
```

## 新機能の追加

### 新しいAIプロバイダーの追加

1. サービスクラスを作成
```dart
// lib/services/new_ai_service.dart
class NewAiService {
  Future<String> generateResponse(String question) async {
    // 実装
  }
}
```

2. HomeScreenに統合
```dart
final _newAiService = NewAiService();

Future<AiResponse> _getNewAiResponse(String question) async {
  try {
    final response = await _newAiService.generateResponse(question);
    return AiResponse(aiName: 'NewAI', response: response);
  } catch (e) {
    return AiResponse(aiName: 'NewAI', error: 'エラー: ${e.toString()}');
  }
}

// _sendQuestion()内で追加
final results = await Future.wait([
  _getGeminiResponse(question),
  _getClaudeResponse(question),
  _getNewAiResponse(question),
]);
```

3. テストを追加
```dart
// test/services/new_ai_service_test.dart
```

4. ドキュメントを更新
- README.md
- SETUP.md（APIキー取得方法）
- ARCHITECTURE.md

## イシューの報告

### バグレポート

以下の情報を含めてください：

```markdown
## バグの説明
何が起こっているか

## 再現手順
1. 〜を開く
2. 〜をクリック
3. 〜を入力
4. エラーが表示される

## 期待される動作
何が起こるべきか

## スクリーンショット
あれば添付

## 環境
- OS: [例: iOS 16.0]
- Flutter: [例: 3.13.0]
- Dart: [例: 3.1.0]

## 追加情報
その他の関連情報
```

### 機能リクエスト

```markdown
## 機能の説明
実装してほしい機能

## モチベーション
なぜこの機能が必要か

## 提案する解決策
どのように実装できるか

## 代替案
検討した他の方法
```

## コードレビュー

### レビュアーとして
- 建設的なフィードバックを提供
- コードだけでなく、テストとドキュメントも確認
- 理解できない部分は質問する
- 良い点も指摘する

### PRオーナーとして
- フィードバックに感謝する
- 質問には丁寧に回答する
- 必要な変更を速やかに実施
- 議論が長引く場合は、同期的な会話を提案

## リリースプロセス

1. バージョン番号を更新（`pubspec.yaml`）
2. CHANGELOGを更新
3. タグを作成
```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```
4. GitHubでリリースノートを作成

## 質問やヘルプ

- イシューで質問を投稿
- ディスカッションを活用
- PRでフィードバックを求める

## ライセンス

このプロジェクトに貢献することで、あなたの貢献が[MITライセンス](LICENSE)の下でライセンスされることに同意するものとします。

---

貢献いただきありがとうございます！ 🎉
