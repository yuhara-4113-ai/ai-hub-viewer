# クイックスタート / Quick Start

最速で AI Hub Viewer を動かすための簡潔なガイドです。

**FVM を使用している場合**: [FVM_SETUP.md](FVM_SETUP.md) を参照してください。

## 5分でスタート

### 1. クローン
```bash
git clone https://github.com/yuhara-4113-ai/ai-hub-viewer.git
cd ai-hub-viewer
```

### 2. 依存関係をインストール
```bash
flutter pub get

# FVM を使用している場合
fvm flutter pub get
```

### 3. APIキーを設定
```bash
# .envファイルを作成
cp .env.example .env

# エディタで.envを開いて、APIキーを貼り付け
# GEMINI_API_KEY=あなたのGeminiキー
# CLAUDE_API_KEY=あなたのClaudeキー
```

### 4. 実行
```bash
flutter run

# FVM を使用している場合
fvm flutter run
```

## APIキーの取得（初めての場合）

### Gemini API キー（無料）
1. https://makersuite.google.com/app/apikey にアクセス
2. Googleアカウントでログイン
3. "Create API Key" → APIキーをコピー
4. `.env` の `GEMINI_API_KEY` に貼り付け

### Claude API キー（無料トライアル）
1. https://console.anthropic.com/ にアクセス
2. アカウント作成
3. "API Keys" → "Create Key" → APIキーをコピー
4. `.env` の `CLAUDE_API_KEY` に貼り付け

## よくあるエラー

### エラー: "flutter: command not found"
```bash
# Flutter SDKをインストール
# https://docs.flutter.dev/get-started/install
```

### エラー: "GEMINI_API_KEY not found"
```bash
# .envファイルが存在するか確認
ls -la .env

# 存在しない場合は作成
cp .env.example .env

# APIキーを設定
nano .env  # または任意のエディタ
```

### エラー: "Failed to get response"
- APIキーが正しいか確認
- インターネット接続を確認
- APIの使用制限を確認

## 次のステップ

- **詳細なセットアップ**: [SETUP.md](SETUP.md) を参照
- **使い方**: [USAGE.md](USAGE.md) を参照
- **開発に参加**: [CONTRIBUTING.md](CONTRIBUTING.md) を参照
- **アーキテクチャ**: [ARCHITECTURE.md](ARCHITECTURE.md) を参照

## 開発コマンド

### 通常の Flutter
```bash
# アプリを起動
flutter run

# テストを実行
flutter test

# コード解析
flutter analyze

# コードフォーマット
dart format .

# ビルド（Web）
flutter build web

# ビルド（Android）
flutter build apk

# デバイス一覧
flutter devices
```

### FVM を使用する場合
すべてのコマンドの前に `fvm` を付けてください：
```bash
# アプリを起動
fvm flutter run

# テストを実行
fvm flutter test

# コード解析
fvm flutter analyze

# コードフォーマット
fvm dart format .

# ビルド（Web）
fvm flutter build web

# ビルド（Android）
fvm flutter build apk

# デバイス一覧
fvm flutter devices
```

詳細は [FVM_SETUP.md](FVM_SETUP.md) を参照してください。

## トラブルシューティング

問題が解決しない場合：

1. [SETUP.md](SETUP.md) のトラブルシューティングセクションを確認
2. GitHubのイシューで検索
3. 新しいイシューを作成

## サポート

- 📚 [README.md](README.md) - プロジェクト概要
- 🛠️ [SETUP.md](SETUP.md) - 詳細セットアップ
- 📖 [USAGE.md](USAGE.md) - 使用方法
- 🏗️ [ARCHITECTURE.md](ARCHITECTURE.md) - 技術ドキュメント
- 🤝 [CONTRIBUTING.md](CONTRIBUTING.md) - 貢献ガイド
- 🎨 [UI_MOCKUP.md](UI_MOCKUP.md) - UIデザイン
