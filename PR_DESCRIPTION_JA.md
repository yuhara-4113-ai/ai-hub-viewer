# Gemini と Claude API を統合した Flutter アプリの実装 - マルチAIクエリ比較

このPRは、ユーザーが Gemini API と Claude API の両方に同時に質問を送信し、両方のAIサービスからの応答を比較表示できる完全な Flutter アプリケーションを実装します。

## 概要

このアプリケーションは、クリーンな Material Design 3 インターフェースを提供し、以下の機能を実現します：
- 複数行のテキストフィールドで質問を入力
- Gemini API と Claude API に並列で質問を送信
- 両方のAIからの応答を縦方向にスクロール可能なリストで表示
- API通信中は視覚的なローディングインジケータでモニタリング
- ユーザーフレンドリーなエラーメッセージで適切にエラーをハンドリング

## 実装の詳細

### アーキテクチャ

アプリケーションはクリーンなレイヤーアーキテクチャに従っています：

**プレゼンテーション層** (`lib/screens/home_screen.dart`)
- 適切な状態管理を持つ StatefulWidget ベースのUI
- 質問入力フィールド、送信ボタン、応答リスト
- ローディングインジケータとエラー表示

**サービス層** (`lib/services/`)
- `GeminiService` - Google の Gemini API (gemini-pro モデル) との統合
- `ClaudeService` - Anthropic の Claude API (claude-3-haiku モデル) との統合
- API通信ロジックの明確な分離

**モデル層** (`lib/models/ai_response.dart`)
- AI応答のイミュータブルなデータモデル
- ローディング、成功、エラー状態をサポート

### 主な機能

**並列API処理**
```dart
final results = await Future.wait([
  _getGeminiResponse(question),
  _getClaudeResponse(question),
]);
```
両方のAPIに同時にクエリを送信し、`Future.wait` を使用して合計応答時間を最小化します。

**安全なAPIキー管理**
- APIキーは `flutter_dotenv` を使用して `.env` ファイルに保存
- `.env` はバージョン管理から除外
- 簡単なセットアップのための `.env.example` テンプレートを提供

**包括的なエラーハンドリング**
- ネットワークエラーをキャッチし、AIサービスごとに表示
- APIキーの欠落を明確なエラーメッセージで検出
- 入力検証により空の送信を防止

**ユーザーエクスペリエンス**
- API呼び出し中のローディングインジケータ
- 処理中は入力を無効化
- Material Design 3 と日本語ローカライゼーション
- 異なる画面サイズに適応するレスポンシブレイアウト

### テスト

**ユニットテスト** (`test/ai_response_test.dart`)
- AiResponse モデルのデータ操作のテスト
- すべてのモデル状態（ローディング、成功、エラー）のカバレッジ

**ウィジェットテスト** (`test/widget_test.dart`)
- UIコンポーネントのレンダリング検証
- ボタン状態の検証
- 入力検証のテスト

### ドキュメント

以下を網羅した包括的なドキュメント：
- **QUICKSTART.md** - 5分でできるセットアップガイド
- **SETUP.md** - 詳細なインストールとAPIキー取得手順
- **USAGE.md** - 使用例とベストプラクティスのユーザーガイド
- **ARCHITECTURE.md** - 技術アーキテクチャと設計判断
- **UI_MOCKUP.md** - すべてのUI状態の視覚的なモックアップ
- **CONTRIBUTING.md** - 貢献者向けの開発ガイドライン

### 依存関係

- `http: ^1.1.0` - REST API呼び出し用のHTTPクライアント
- `flutter_dotenv: ^5.1.0` - 環境変数管理
- `flutter_lints: ^3.0.0` - コード品質とリンティング

### API設定

ユーザーは以下から無料のAPIキーを取得する必要があります：
- **Gemini API**: https://makersuite.google.com/app/apikey
- **Claude API**: https://console.anthropic.com/

両方のAPIとも、開発とテストに適した無料枠を提供しています。

## はじめ方

```bash
git clone https://github.com/yuhara-4113-ai/ai-hub-viewer.git
cd ai-hub-viewer
flutter pub get
cp .env.example .env
# APIキーで.envを編集
flutter run
```

詳細なセットアップ手順は `QUICKSTART.md` を参照してください。

## テスト

```bash
# すべてのテストを実行
flutter test

# カバレッジ付きで実行
flutter test --coverage

# コード解析
flutter analyze
```

すべてのテストが正常に合格し、コード解析でも問題は見つかりませんでした。

---

この実装は、将来的に追加のAIプロバイダー、応答履歴、お気に入りなどの機能を簡単に拡張できる、本番環境対応の基盤を提供します。
