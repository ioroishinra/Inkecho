# Inkecho

和語を中心に、日本語の語彙をカードで学ぶ、iPhone・iPad・Mac向けアプリ。

言葉の読み方や意味を例文とともに確かめながら、一語ずつ覚えていけます。和紙や墨を思わせる落ち着いた画面で、日々の学習を続けられます。

## できること

- カードをめくって、読み方・意味・例文を確認
- 覚えた言葉を記録し、未習得の語彙を重点的に復習
- 学習履歴や習得状況を確認
- 「暗墨」「和紙」「夜桜」の3つのテーマを切り替え

## 開発

iOS 17以降・macOS 14以降に対応しています。XcodeとXcodeGenを用意し、リポジトリのルートで次のコマンドを実行してください。

```sh
xcodegen generate
open Inkecho.xcodeproj
```

実機で動かす場合は、Xcodeで署名用のチームを設定してください。学習データは端末内に保存されます。

## 構成

- `Apps/`：iOS・macOSのアプリ本体
- `Packages/`：Swift Package Managerのモジュール
- `project.yml`：XcodeGenのプロジェクト定義

## 使用技術

Swift・SwiftUI・SwiftData・XcodeGen・SwiftLint
