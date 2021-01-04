# Vuls-auto スクリプトの更新について

## 目的

`CentOS7（172,16.72.40）`において、コマンドの定時実行などのスケジュール管理を行うために用いるコマンド`crontab`が管理する自動実行ファイル（`/var/spool/cron/vuls`）の保守を不要にする。



## 変更点

 `crontab`が管理する自動実行ファイル（`/var/spool/cron/vuls`）では、自動実行スクリプト `vuls-auto.sh` をプロジェクトごとに作成しこれを実行していたが、この方法をやめ、指定のフォルダに存在するフォルダをプロジェクトとみなし、フォルダの数だけスキャンを行う。

 指定のフォルダとは、

`CentOS7`上では、

​	`/mnt/z/空調生産本部ITソリューション開発Ｇ/LVL2/開発g/脆弱性情報/vuls/`

`Windows10`上では、

​	`Z:\空調生産本部ITソリューション開発Ｇ\LVL2\開発g\脆弱性情報\vuls`

この変更により、自動実行ファイル`/var/spool/cron/vuls`の保守が不要になる。



## 新プロジェクト適用手順

　新しいプロジェクトを適用する場合は、このフォルダの下にプロジェクトの名前が付いたフォルダを置くこと。（`z-today`の場合と異なり、`Vuls`の場合は、プロジェクト名のフォルダの下に、処理が終わったファイルを移動するためのフォルダ`done`の作成は不要）



### 変更ファイル：`/var/spool/cron/vuls`

#### 変更前

```5 6 * * 1-5 /home/vuls/vuls-auto-GPF.sh full diff > /var/log/vuls/GPF/vuls-auto-GPF.log 2>&1
30 6 * * 1-5 /home/vuls/vuls-auto-netZEAS.sh full diff > /var/log/vuls/netZEAS/vuls-auto-netZEAS.log 2>&1
55 6 * * 1-5 /home/vuls/vuls-auto-type_h.sh full diff > /var/log/vuls/type_h/vuls-auto-type_h.log 2>&1
20 7 * * 1-5 /home/vuls/vuls-auto-ERMS.sh full diff > /var/log/vuls/ERMS/vuls-auto-ERMS.log 2>&1```
```

​	※プロジェクトごとにシェルスクリプトを用意。プロジェクトが増えるたびに、同様の行の追加が必要

#### 変更後

​	```05 6 * * 1-5 /home/vuls/vuls-auto2.sh full diff > /var/log/vuls/vuls-auto.log 2>&1```

​	※プロジェクト共通のシェルスクリプトを作成したので、プロジェクトごとのシェルスクリプトが不要になり、自動実行ファイル`vuls`の保守が不要

​	※シェルスクリプトは、`vuls-auto.sh`から、`vuls-auto2.sh`に変更した



### 変更ファイル：/home/vuls/vuls-auto2.sh

#### 変更前（/home/vuls/vuls-auto.sh）

​	プロジェクトごとにシェルスクリプトを用意し、単一プロジェクトについてのみ処理

#### 変更後（/home/vuls/vuls-auto2.sh）

​	プロジェクトごとにシェルスクリプトを作成することをせず、上記フォルダを巡回し、存在するフォルダ名をプロジェクト名として処理