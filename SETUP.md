# セットアップガイド / Setup Guide

このドキュメントでは、AI Hub Viewerアプリのセットアップ方法を詳しく説明します。

## 前提条件 / Prerequisites

### 必要なソフトウェア
- Flutter SDK 3.0.0以上
- Dart SDK 3.0.0以上
- 任意のエディタ（VS Code、Android Studio推奨）

### APIキーの取得

#### 1. Gemini API キー

1. [Google AI Studio](https://makersuite.google.com/app/apikey) にアクセス
2. Googleアカウントでログイン
3. "Create API Key" をクリック
4. プロジェクトを選択（または新規作成）
5. 生成されたAPIキーをコピー

**無料枠の制限:**
- 1分あたり60リクエスト
- 1日あたり1,500リクエスト

#### 2. Claude API キー

1. [Anthropic Console](https://console.anthropic.com/) にアクセス
2. アカウントを作成またはログイン
3. "API Keys" セクションに移動
4. "Create Key" をクリック
5. 生成されたAPIキーをコピー

**無料枠の制限:**
- 新規ユーザーには初回クレジットが提供されます
- Claude 3 Haiku モデルは最もコスト効率が良いです

## インストール手順 / Installation Steps

### 1. リポジトリのクローン

```bash
git clone https://github.com/yuhara-4113-ai/ai-hub-viewer.git
cd ai-hub-viewer
```

### 2. 依存関係のインストール

```bash
flutter pub get
```

### 3. 環境変数の設定

`.env.example` を `.env` にコピーします：

```bash
cp .env.example .env
```

`.env` ファイルを編集して、取得したAPIキーを設定します：

```
GEMINI_API_KEY=your_actual_gemini_api_key_here
CLAUDE_API_KEY=your_actual_claude_api_key_here
```

**重要:** `.env` ファイルは `.gitignore` に含まれているため、リポジトリにコミットされません。

### 4. アプリの実行

```bash
# デバイス/エミュレータを確認
flutter devices

# アプリを起動
flutter run
```

または、特定のデバイスで実行：

```bash
flutter run -d chrome  # Web版
flutter run -d <device-id>  # 特定のデバイス
```

## トラブルシューティング / Troubleshooting

### Flutter関連の問題

#### 問題: "flutter: command not found"
**解決策:** 
```bash
# Flutter SDKがインストールされているか確認
which flutter

# PATHに追加されているか確認
echo $PATH

# 必要に応じて.bashrcや.zshrcに追加
export PATH="$PATH:/path/to/flutter/bin"
```

#### 問題: "Waiting for another flutter command to release the startup lock..."
**解決策:**
```bash
killall -9 dart
rm -rf /path/to/flutter/bin/cache/lockfile
```

### API関連の問題

#### 問題: "GEMINI_API_KEY not found in .env file"
**解決策:**
- `.env` ファイルが存在することを確認
- APIキーが正しく設定されていることを確認
- アプリを再起動

#### 問題: "Failed to get response from Gemini"
**考えられる原因:**
1. APIキーが無効または期限切れ
2. APIの使用制限に達している
3. ネットワーク接続の問題

**解決策:**
- APIキーが正しいことを確認
- [Google AI Studio](https://makersuite.google.com/app/apikey) でAPIキーを再生成
- 使用制限をチェック

#### 問題: "Failed to get response from Claude"
**考えられる原因:**
1. APIキーが無効
2. クレジットが不足している
3. APIリクエストの形式が間違っている

**解決策:**
- [Anthropic Console](https://console.anthropic.com/) でAPIキーとクレジット残高を確認
- 必要に応じて新しいAPIキーを生成

## テストの実行 / Running Tests

```bash
# すべてのテストを実行
flutter test

# 特定のテストファイルを実行
flutter test test/ai_response_test.dart

# カバレッジレポートを生成
flutter test --coverage
```

## ビルド / Building

### Webアプリとしてビルド

```bash
flutter build web
```

ビルドされたファイルは `build/web/` ディレクトリに生成されます。

### Android APKをビルド

```bash
flutter build apk --release
```

### iOS アプリをビルド

```bash
flutter build ios --release
```

## 開発のヒント / Development Tips

### ホットリロード
アプリ実行中に `r` を押すとホットリロードが実行されます。

### ホットリスタート
アプリ実行中に `R` を押すとホットリスタートが実行されます。

### デバッグモード
```bash
flutter run --debug
```

### リリースモード
```bash
flutter run --release
```

## APIの使用制限について

### Gemini API
- **無料枠:** 1分あたり60リクエスト、1日あたり1,500リクエスト
- **推奨モデル:** gemini-pro（テキスト生成に最適）

### Claude API
- **無料枠:** 新規ユーザーに初回クレジット提供
- **推奨モデル:** claude-3-haiku-20240307（コスト効率が良い）
- **料金:** 使用量に応じて課金（詳細は[料金ページ](https://www.anthropic.com/pricing)を参照）

## セキュリティのベストプラクティス

1. **APIキーの管理:**
   - APIキーをコードに直接書かない
   - `.env` ファイルを使用
   - `.env` ファイルを絶対にコミットしない

2. **公開時の注意:**
   - リポジトリを公開する場合、`.env.example` のみを含める
   - 実際のAPIキーは含めない

3. **使用制限の設定:**
   - APIコンソールで使用制限を設定
   - 予期しない高額請求を防ぐ

## さらに詳しく

- [Flutter公式ドキュメント](https://docs.flutter.dev/)
- [Gemini API ドキュメント](https://ai.google.dev/docs)
- [Claude API ドキュメント](https://docs.anthropic.com/)
