# FVM を使用したセットアップ / Setup with FVM

このドキュメントでは、FVM (Flutter Version Management) を使用してプロジェクトをセットアップする方法を説明します。

## FVM とは

FVM は Flutter SDK のバージョンを管理するツールです。プロジェクトごとに異なる Flutter バージョンを使用できます。

## 前提条件

FVM がインストールされていること。まだの場合：

```bash
# Dart pub経由でインストール
dart pub global activate fvm

# または Homebrew (macOS)
brew tap leoafarias/fvm
brew install fvm
```

## セットアップ手順

### 1. FVM で Flutter をインストール

```bash
# 推奨バージョン（Flutter 3.16.0以上）をインストール
fvm install 3.16.0

# または最新の安定版をインストール
fvm install stable
```

### 2. プロジェクトでFVMを使用

```bash
# プロジェクトディレクトリに移動
cd ai-hub-viewer

# プロジェクトで使用する Flutter バージョンを設定
fvm use 3.16.0

# または最新の安定版を使用
fvm use stable
```

これにより、`.fvm` ディレクトリと `.fvmrc` ファイルが作成されます。

### 3. 依存関係をインストール

```bash
# FVM経由でflutterコマンドを実行
fvm flutter pub get
```

### 4. APIキーを設定

```bash
# .envファイルを作成
cp .env.example .env

# エディタで.envを開いてAPIキーを追加
# GEMINI_API_KEY=あなたのGeminiキー
# CLAUDE_API_KEY=あなたのClaudeキー
```

### 5. アプリを実行

```bash
# FVM経由でアプリを実行
fvm flutter run
```

## FVM コマンド一覧

### 基本コマンド

```bash
# インストール済みのFlutterバージョンを確認
fvm list

# 使用可能なFlutterバージョンを確認
fvm releases

# 特定のバージョンをインストール
fvm install <version>

# プロジェクトで使用するバージョンを設定
fvm use <version>

# グローバルデフォルトバージョンを設定
fvm global <version>

# 現在のバージョンを確認
fvm flutter --version
```

### 開発コマンド

すべての `flutter` コマンドの前に `fvm` を付けて実行：

```bash
# アプリを起動
fvm flutter run

# テストを実行
fvm flutter test

# コード解析
fvm flutter analyze

# コードフォーマット
fvm dart format .

# デバイス一覧
fvm flutter devices

# ビルド（Web）
fvm flutter build web

# ビルド（Android）
fvm flutter build apk
```

## IDE の設定

### VS Code

1. `.vscode/settings.json` を作成（または編集）

```json
{
  "dart.flutterSdkPath": ".fvm/flutter_sdk",
  "search.exclude": {
    "**/.fvm": true
  },
  "files.watcherExclude": {
    "**/.fvm": true
  }
}
```

2. VS Code を再起動

### Android Studio / IntelliJ

1. **Settings/Preferences** → **Languages & Frameworks** → **Flutter** を開く
2. **Flutter SDK path** に `.fvm/flutter_sdk` のフルパスを設定
   - 例: `/Users/username/projects/ai-hub-viewer/.fvm/flutter_sdk`

## .gitignore の設定

FVM を使用する場合、以下を `.gitignore` に追加することを推奨：

```gitignore
# FVM Version Cache
.fvm/

# FVM configuration (オプション - チームで共有する場合はコミット)
.fvmrc
```

**注意**: `.fvmrc` をコミットすると、チームメンバー全員が同じ Flutter バージョンを使用できます。

## チーム開発での使用

### プロジェクトに .fvmrc を含める場合

1. プロジェクトオーナーが `.fvmrc` を作成：
```bash
fvm use 3.16.0
git add .fvmrc
git commit -m "Add FVM configuration"
```

2. チームメンバーがプロジェクトをクローン後：
```bash
cd ai-hub-viewer
fvm install  # .fvmrcに記載されたバージョンを自動インストール
fvm flutter pub get
```

## トラブルシューティング

### 問題: "fvm: command not found"

**解決策**:
```bash
# PATHに追加（~/.zshrc または ~/.bashrc）
export PATH="$PATH:$HOME/.pub-cache/bin"

# 設定を再読み込み
source ~/.zshrc  # または source ~/.bashrc
```

### 問題: VS Code で Dart SDK が見つからない

**解決策**:
1. `.vscode/settings.json` に正しいパスを設定
2. VS Code を再起動
3. `Dart: Restart Analysis Server` コマンドを実行

### 問題: Flutter バージョンが切り替わらない

**解決策**:
```bash
# キャッシュをクリア
fvm flutter clean
fvm flutter pub get

# または FVM を再設定
fvm use 3.16.0 --force
```

### 問題: Android Studio で Flutter SDK を認識しない

**解決策**:
- `.fvm/flutter_sdk` への絶対パスを使用
- シンボリックリンクではなく、実際のパスを確認
- Android Studio を再起動

## 推奨バージョン

このプロジェクトでは以下のバージョンを推奨：

- **Flutter**: 3.16.0 以上
- **Dart**: 3.2.0 以上

現在のバージョンを確認：
```bash
fvm flutter --version
fvm dart --version
```

## FVM のメリット

1. **プロジェクトごとの独立性**: 各プロジェクトで異なる Flutter バージョンを使用
2. **チーム統一**: `.fvmrc` でチーム全体が同じバージョンを使用
3. **簡単な切り替え**: バージョン間の切り替えが簡単
4. **CI/CD 対応**: 継続的インテグレーションで一貫性を保証

## さらに詳しく

- [FVM 公式ドキュメント](https://fvm.app/)
- [FVM GitHub リポジトリ](https://github.com/leoafarias/fvm)

---

## クイックリファレンス

### 初回セットアップ（FVM使用）
```bash
# 1. FVM をインストール（初回のみ）
dart pub global activate fvm

# 2. プロジェクトをクローン
git clone https://github.com/yuhara-4113-ai/ai-hub-viewer.git
cd ai-hub-viewer

# 3. Flutter バージョンを設定
fvm use 3.16.0

# 4. 依存関係をインストール
fvm flutter pub get

# 5. APIキーを設定
cp .env.example .env
# .env を編集

# 6. アプリを実行
fvm flutter run
```

### 日常的な使用
```bash
# アプリ実行
fvm flutter run

# テスト
fvm flutter test

# コード解析
fvm flutter analyze
```

すべて準備完了です！ 🚀
