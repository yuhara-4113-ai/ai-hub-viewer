# AI Hub Viewer

Flutter アプリケーションで複数のAI API（Gemini と Claude）に質問を送信し、回答を比較表示するアプリです。

## 🎯 機能

- ユーザーが入力した質問を Gemini API と Claude API の両方に同時送信
- 各AIの回答を一覧表示（縦並び）
- 通信中はローディングインジケータを表示
- エラーハンドリング機能

## 📋 必要要件

- Flutter SDK (3.0.0以上)
- Dart SDK (3.0.0以上)
- Gemini API キー（無料枠で利用可能）
- Claude API キー（無料枠で利用可能）

## 🚀 セットアップ

1. リポジトリをクローン
```bash
git clone https://github.com/yuhara-4113-ai/ai-hub-viewer.git
cd ai-hub-viewer
```

2. 依存関係をインストール
```bash
flutter pub get
```

3. APIキーの設定

`.env.example` を `.env` にコピーして、APIキーを設定してください：

```bash
cp .env.example .env
```

`.env` ファイルを編集して、以下のキーを設定：

```
GEMINI_API_KEY=your_actual_gemini_api_key
CLAUDE_API_KEY=your_actual_claude_api_key
```

### APIキーの取得方法

- **Gemini API**: [Google AI Studio](https://makersuite.google.com/app/apikey) から無料で取得可能
- **Claude API**: [Anthropic Console](https://console.anthropic.com/) から取得可能

## 🏃 実行方法

```bash
flutter run
```

## 📱 使用方法

1. アプリを起動
2. テキストフィールドに質問を入力
3. 「送信」ボタンをクリック
4. Gemini と Claude の両方からの回答が表示されます

## 🧪 テスト

```bash
flutter test
```

## 📦 使用しているパッケージ

- `http`: HTTP リクエスト用
- `flutter_dotenv`: 環境変数管理用
- `flutter_lints`: コード品質チェック用

## 🔒 セキュリティ

- `.env` ファイルは `.gitignore` に含まれており、リポジトリにコミットされません
- APIキーは環境変数として管理されます

## 📝 ライセンス

MIT License