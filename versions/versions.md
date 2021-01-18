# *versions.sh*

## 概要

`vuls`が利用するライブラリーやツール類のバージョンをまとめて収集・表示するスクリプト
- 本スクリプトの利用者は、`CentOS7`のターミナルから、コマンド`versions.sh`を引数なしで実行する
- 結果をファイルに保存する場合は、以下のリダイレクトを行う
  - `$ ./versions.sh > versions-20210115-CentOS7.txt 2>&1`
- `GitLab`に`issue`を発行する際にバージョン情報が必要になる（次項の※印）

## 表示対象ソフトウェアと表示例

- **CentOS** ※
  - CentOS Linux release 7.3.1611 (Core)
- **SQLite** ※
  - SQLite version 3.7.17 2013-05-20 00:56:22
- git
  - git version 2.9.3
- gcc
  - gcc バージョン 4.8.5 20150623 (Red Hat 4.8.5-39) (GCC)
- GNU Make
  - GNU Make 3.82
- GNU Wget
  - GNU Wget 1.14 built on linux-gnu.
- yum-utils
  - yum-utils 3.4.3
- **go** ※
  - go version go1.13.8 linux/amd64
- **go-cpe-dictionary** ※
  - go-cpe-dictionary v0.2.5 3183fd0
- **go-cve-dictionary** ※
  - go-cve-dictionary v0.4.1 4a02438
- **goval-dictionary** ※
  - goval-dictionary v0.2.4 85c5c09
- **gost** ※
  - gost 76d68fe
- **go-exploitdb** ※
  - go-exploitdb  v0.1.2
- **vuls** ※
  - vuls v0.15.2 build-20210118_095239_d6435d2
- peco
  - peco version v0.5.3 (built with go1.10)
- su
  - su from util-linux 2.23.2
- sudo
  - Sudo バージョン 1.8.6p7
- sudoers
  - sudoers ポリシープラグイン バージョン 1.8.6p7
  - sudoers ファイル⽂法バージョン 42
  - Sudoers I/O plugin version 1.8.6p7

---
