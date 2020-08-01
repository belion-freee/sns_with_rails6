[![CircleCI](https://circleci.com/gh/belion-freee/sns_with_rails6.svg?style=svg)](https://circleci.com/gh/belion-freee/sns_with_rails6)

# SNS App with Rails 6.0
Ruby on Rails学習者とメンターさん向けのサンプルアプリケーション

## Demo
サンプルアプリケーションの動作はこのようになります。

<img src="https://user-images.githubusercontent.com/34331230/88256022-0750a180-ccf5-11ea-8849-11a040b4d51f.gif" width="600px">

## 用途
Rails初学者向けに以下の要件を満たす目的で作成されたサンプルアプリケーション。

- ソースリーディング力の向上
- GitHubでのプルリクの使い方の理解
- よくある機能の実装サンプルを掲示することでメンタリングの効率化

## アプリケーションの内容
このアプリケーションはRails6で制作された簡易ブログです。

### 実装されてる機能の一覧

- deviceを使ったユーザー管理とログイン・ログアウト機能
- ブログ機能
- コメント機能
- お気に入り機能
- 検索機能
- 画像アップロード機能
- ページネーション
- Rspecを使ったテスト
- CircleCIによる自動テスト

## どのように利用するのか？
実装されてる機能毎にプルリクを作り詳細な解説を加えているので、ソースリーディングの練習として利用することを想定しています。

Dockerを使用しているので、ローカルにpullして開発環境を立ち上げて自分でデバッグしながら動作確認もできます。

また、そのまま機能追加していくことで、ポートフォリオの雛形としても利用できます。

### プルリクエスト
実装されてる機能の一覧と対応してるプルリクエストのリンクです。

- [deviceを使ったユーザー管理とログイン・ログアウト機能](https://github.com/belion-freee/sns_with_rails6/pull/1)
  - deviceを導入してのユーザーのセッション管理を実装しています
- [ブログ機能](https://github.com/belion-freee/sns_with_rails6/pull/1)
  - Rails6の機能であるActionTextを利用してのブログのCRUD機能を実装しています。
- [コメント機能](https://github.com/belion-freee/sns_with_rails6/pull/3)
  - Ajaxを利用してのコメントの追加、削除機能を実装しています。
- [お気に入り機能](https://github.com/belion-freee/sns_with_rails6/pull/6)
  - Ajaxを利用してのお気に入りの追加、削除機能を実装しています。
- [検索機能](https://github.com/belion-freee/sns_with_rails6/pull/8)
  - 検索機能を実装しています。Ransackではなくて自前で実装してます。
- [画像アップロード機能](https://github.com/belion-freee/sns_with_rails6/pull/9)
  - carrierwaveを使って画像アップロード機能を実装してます。
- [ページネーション](https://github.com/belion-freee/sns_with_rails6/pull/10)
  - kaminariを使って画像アップロード機能を実装してます。
- [Rspecを使ったテスト](https://github.com/belion-freee/sns_with_rails6/pull/11)
  - Rspecで、単体テストと統合テストを実装しています。
- [CircleCIによる自動テスト](https://github.com/belion-freee/sns_with_rails6/pull/12)
  - 自動テストの設定とREADMEへのバッジ追加を実装してます。
  
#### 参考になりそうなプルリクエスト
以下は見なくてもいいけど参考になりそうなプルリクエストです。

- [初期データ投入](https://github.com/belion-freee/sns_with_rails6/pull/4)
  - seedsファイルを使って初期データの投入をしています。
- [デザインの修正](https://github.com/belion-freee/sns_with_rails6/pull/5)
  - Bootstrap4の機能をなるべく使うようにしてます。css書かなくてもわりと調整できます。

### ローカルで動かす
GitHubからpullしてきたらプロジェクトフォルダに移動して、`./qs init --webpack`してください。

```
$ git clone https://github.com/belion-freee/sns_with_rails6.git <Project name>
$ cd <Project name>
$ ./qs init --webpack
```

`http://localhost:3000`にアクセスするとアプリが利用可能です。

以降の開発では `./qs server` でアプリを起動すると、webpack-dev-serverによるホットリロードが実行されるので、オススメです。


seedで初期アカウントを登録してるので、すぐに動作確認できます。
```
# You can use those accounts

name: "hoge"
email: "hoge@sample.com"
password: "Password"

name: "foo"
email: "foo@sample.com"
password: "Password"
```

