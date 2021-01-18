# *vuls-test.sh*

## 概要

新しく作成したプロジェクト用`config.toml`の`cpe`記述をテストするスクリプト
- 本スクリプトの利用者は、`CentOS7`のターミナルから、コマンド`vuls-test.sh`を引数付きで実行する
- 引数に間違いない場合、本スクリプトは`vuls scan`（スキャン）および `vuls report`（レポート）コマンドを実行する
- スキャンとレポートを実行後、`config.toml`に問題がない場合は、`config.email`に記述したメールの宛先に結果をメールで通知する
- `config.toml`にタイポなどの問題がある場合は、メールが届かないので、ログを確認する
- `config.toml`の本来のメール送信先（`[email]`セクション）を、テスト用に、`config.email`に記述したメールアドレスに書き換えている（`config.toml`に記述したメールアドレスの検証は行わない）

## ファイルの説明

### 1. `vuls-test.sh`

- 手作業で`config.toml`の`cpe`記述をテストするシェルスクリプト

- `/home/vuls/` 直下にある

- 引数が３つ必要
  - 一つ目、`full | one`
    - 書式がフルかワンラインか
  - 二つ目、`full | diff`
    - レポートがフルか前回との差分か
  - 三つ目、新しく作成したプロジェクト名

- 実行例

```bash
[vuls@localhost ~]$ ./vuls-test.sh full diff Project-A
```

- 引数が足りない場合は使い方を表示する
  
```bash
[vuls@localhost ~]$ ./vuls-test.sh full diff
    Usage: $ ./vuls-test.sh FORMAT OUTPUT PROJECT
           FORMAT:  full | one
           OUTPUT:  full | diff
           PROJECT: e.g. Project-A
```

### 2. `config.toml`

- 被テストファイル
- 各プロジェクトごとに用意する設定ファイル
- `/home/vuls/config/` 下の各プロジェクト名フォルダの下にある

### 3. `config.test`

- `config.toml`の先頭から`{email]`セクションの手前までを切り出した中間ファイル
- 例

```bash
[servers]
servers.Project-A]
ype = "pseudo"
peNames = [
	"cpe:2.3:a:acl_project:acl:2.2.51:*:*:*:*:*:*:*",
	"cpe:2.3:a:alsa-project:alsa:1.1.8:*:*:*:*:*:*:*",

（略）

	"cpe:2.3:a:jquery:jquery:1.19.0:-:*:*:*:*:*:*",
	"cpe:2.3:a:mit:kerberos_5:1.15.1:-:*:*:*:*:*:*",
	]

servers.Project-B]
ype = "pseudo"
peNames = [
	"cpe:2.3:a:acl_project:acl:2.2.51:*:*:*:*:*:*:*",
	"cpe:2.3:a:linux_audit_project:linux_audit:2.8.5:*:*:*:*:*:*:*",

（略）

	"cpe:2.3:a:zlib:zlib:1.2.7:*:*:*:*:*:*:*",
	"cpe:2.3:a:mit:kerberos_5:1.15.1:-:*:*:*:*:*:*",
	]
```
   
### 4. `config.email`

- テスト・メンバーのメールアドレスを記述した`[email]`セクション
- `config.test`と`config.email`を連結して`config.test.toml`を作成する

```bash
[email]
smtpAddr = "localhost"
smtpPort = "25"
from = "vuls@abcd.com"
to = [
	"aaaa@abcd.com",
	"bbbb@abcd.com",
	]
cc = [
	"cccc@abcd.com",
	"dddd@abcd.com",
	]
subjectPrefix = "[VulsReport]"
```

### 5. `config.test.toml`

- 本ツールが使用する`config.toml`ファイルで、`config.test`と`config.email`を連結している
- `vuls scan`および`vuls report`コマンド実行の際に使用する`config.toml`

## 実行環境

1. サーバー

- `CentOS7`

2. ユーザー

- 本ツール実行ユーザーは、`vuls`

## 実行結果の保存先

- 結果
  - `/home/vuls/results-test/`フォルダ下にプロジェクトごとに保存される
  - プロジェクト名のフォルダは自動作成

- レポート
  - `/home/vuls/reports-test/`フォルダ下にプロジェクトごとに保存される
  - プロジェクト名のフォルダは自動作成

- ログ
  - `/var/log/vuls/`フォルダ下にプロジェクトごとに保存される

---
