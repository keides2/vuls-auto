# vuls-auto

Vuls を使い CVE辞書、CPE辞書 の更新や、検索～レポート出力などを行う自動実行スクリプト

## 1. ファイルの説明

1. `vuls-auto2.sh`

   `cron`が呼び出す自動実行シェルスクリプト

   `/home/vuls` 直下にある

   ※プロジェクト共通シェルスクリプトに変更したので、新しいプロジェクトを追加する場合でも、変数`PROJECT`と`DEST`の変更は不要。詳細は、`doc`にある`vuls-auto スクリプトの更新.md`および`[Vuls] 脆弱性情報収集検知システム管理者向け情報`参照のこと

2. `config.toml`

   各プロジェクトごとに用意する設定ファイル

   `/home/vuls/config` 下の各プロジェクト名フォルダの下にある

   `[servers.?????]` `?????`にプロジェクト名を書く

   CPEリスト`cpeNames` とメールの宛先 `to`と`cc`を編集する

3. `crontab`用`vuls`

   `cron`が読みだす自動実行シェルスクリプト

   ファイル名は実行ユーザ名となる

   `/var/spool/cron` にある `vuls`ファイルを`$ crontab -e`コマンドを使い編集すること

   自動実行したい時刻に呼び出す自動実行シェルスクリプトを記述している

   ※呼び出しているファイル`vuls-auto2.sh`をプロジェクト共通にしたので、通常は、`vuls` ファイルの編集が不要

## 2. 実行環境

1. サーバー

    CentOS7@xxx.xxx.xxx.xxx on ESXi6.0

2. ユーザー

   Vuls スキャン実行ユーザーは、`vuls`

   cron実行ユーザーは、`root`

## 3. フォルダ構成

#### `crontab` とログ関係

```
/var
|-- log
|   |-- vuls
|   |   |-- Project-A
|   |        |-- localhost.log
|   |        |-- cve-dictionary.log
|   |   |-- Project-B
|   |        |-- localhost.log
|   |        |-- cve-dictionary.log
|   |   |-- Project-C
|   |        |-- localhost.log
|   |        |-- cve-dictionary.log
|   |   |-- Project-D
|   |        |-- localhost.log
|   |        |-- cve-dictionary.log
|   |  vuls-auto.log
|   |  z-today-mail.log
|   |  cve-dictionary.log
|   |  go-cpe-dictionary.log
|-- spool
|   |-- cron -- vuls
```

#### 自動実行シェルスクリプト関係

```
/home/vuls
|    |-- config
|    |    |-- Project-A
|    |    |    |-- config.toml
|    |    |-- Project-B
|    |    |    |-- config.toml
|    |    |-- Project-C
|    |    |    |-- config.toml
|    |    |-- Project-D
|    |         |-- config.toml
|    |
|    |-- reports
|    |    |-- Project-A
|    |    |    |-- Vuls-Report-[Project-A]-......txt
|    |    |-- Project-B
|    |    |    |-- Vuls-Report-[Project-B]-......txt
|    |    |-- Project-C
|    |    |    |-- Vuls-Report-[Project-C]-......txt
|    |    |-- Project-D
|    |         |-- Vuls-Report-[Project-D]-......txt
|    |
|    |-- results
|    |    |-- Project-A
|    |    |    |-- 2020-04-....
|    |    |-- Project-B
|    |    |    |-- 2020-04-....
|    |    |-- Project-C
|    |    |    |-- 2020-04-....
|    |    |-- Project-D
|    |         |-- 2020-04-....
|    |
|    |-- vulsrepo
```

## 4.  実行結果の保存先

Vuls のレポートがZドライブの以下のフォルダにプロジェクトごとに保存される

`Z:\path\to\vuls\`

## 5. ライセンス LICENSE

事情によりしばらく `NO LICENSE` といたしますので、`GitHub` の利用規約と著作権法が定める範囲を超えた利用・複製・再頒布などを一切禁止させていただきます。

Due to circumstances, it will be `NO LICENSE` for a while, so I will prohibit any use, duplication, redistribution, etc. beyond the scope of the tProject-D of service of `GitHub` and the copyright law.