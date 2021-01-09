#!/bin/bash

# $1 FORMAT: full = -format-full-text, one = -format-one-line-text
# $2 DIFF: diff = -diff
# $3 不要

if [ $# -ne 2 ]
then
	echo "    Usage: $ ./vuls-auto.sh FORMAT OUTPUT"
	echo "           FORMAT:  full | one"
	echo "           OUTPUT:  full | diff"
	exit
fi

# define
ARG1="$1"
ARG2="$2"
TODAY="`date +%Y%m%d`"

if [ "$ARG1" = "full" ]
then
	FORMAT="-format-full-text"
else
	FORMAT="-format-one-line-text"
fi

if [ "$ARG2" = "diff" ]
then
	DIFF="-diff"
else
	DIFF=""
fi

echo "Format: ""$FORMAT"
echo "Diff: ""$DIFF"
echo "Today: ""$TODAY"
echo "Output: ""Vuls-Report"$FORMAT"-"$TODAY$DIFF".txt"

# ホームディレクトリに移動
cd
pwd

# zドライブのマウント
# sudo mount -t drvfs '\\xxxx.xxxx.xxxx.xxxx\path\to\z' /mnt/z

# 静的スキャン
# cpeNames にあるソフトウェアのバージョンを検出する
# config.toml の cpeNames を編集しておくこと
# cinfgi.toml を各プロジェクトごとに用意する → $ vuls scan -config=/path/to/config.toml

# CPEをフェッチ
echo
echo "Fetching CPE from NVD starts..."
go-cpe-dictionary fetchnvd -http-proxy=http://proxy.abcd.com:3128/

# OVALをフェッチ
# echo
# echo "Fetching OVAL starts..."
# goval-dictionary fetch-redhat 7 8 -http-proxy=http://proxy.abcd.com:3128/

# gostをフェッチ
# echo
# echo "Fetching gost starts..."
# gost fetch redhat 2016-01-01 --http-proxy http://proxy.abcd.com:3128/

# ExploitDBをフェッチ
echo
echo "Fetching ExploitDB starts..."
go-exploitdb fetch exploitdb --http-proxy http://proxy.abcd.com:3128/

# CVE最新版をフェッチ NVD
echo
echo "Fetching NVD starts..."
go-cve-dictionary fetchnvd -http-proxy=http://proxy.abcd.com:3128/ -latest

# CVE最新版をフェッチ JVN
echo
echo "Fetching JVN starts..."
go-cve-dictionary fetchjvn -http-proxy=http://proxy.abcd.com:3128/ -latest

# プロジェクトごとに実施
cd ~
for PROJECT in `ls ./config`
do
	echo "Project: ""$PROJECT"
	CONFIG="/home/vuls/config/$PROJECT/config.toml"
	RESULTS="/home/vuls/results/$PROJECT"
	REPORTS="/home/vuls/reports/$PROJECT"
	LOGDIR="/var/log/vuls/$PROJECT"
	DEST="/mnt/z/path/to/vuls/$PROJECT"
	echo "Dest: "$DEST

	# 検出 scan ～ レポート report
	echo
	echo "Vuls Scanning ["$PROJECT"] starts..."
	vuls scan -config=$CONFIG -results-dir=$RESULTS -log-dir=$LOGDIR

	echo
	echo "Vuls Reporting ["$PROJECT"] starts..."

	# Teams へ投稿
	# $ vuls report $FORMAT -lang ja $DIFF -to-slack -http-proxy=http://proxy.abcd.com:3128/ > "Vuls-Report-["$PROJECT"]"$FORMAT"-"$TODAY$DIFF".txt"
	# を試行。Teams への投稿と同時にファイル保存ができた。
	# 脆弱性情報を検出した場合、Teams への投稿内容は情報が少ない
	# 「project-A Total: 1 (High:0 Medium:0 Low:1 ?:0)    0/0 Fixed   0 installed, 0 updatable    0 exploits  en: 0, ja: 0 alerts」と、
	# 「1/1 for project-A」の2件が投稿されたが、CVE番号ほかの内容が発信されない
	# また、検出があった場合のみ投稿することができるとよいが、Vulsを改変するか、一旦ファイル保存してからテキスト処理を行い投稿する必要がある
	
	# レポート
	vuls report -format-json $FORMAT -lang ja $DIFF -config=$CONFIG -results-dir=$RESULTS -log-dir=$LOGDIR -to-email > "$REPORTS/Vuls-Report-["$PROJECT"]"$FORMAT"-"$TODAY$DIFF".txt"
	# vuls report -format-json $FORMAT -lang ja $DIFF -to-email > "Vuls-Report-[project-A]"$FORMAT"-"$TODAY$DIFF".txt"

	# レポートファイルを $DEST フォルダへコピーする
	cp $REPORTS/Vuls-Report-*.txt $DEST

	# レポートファイルを「reports」フォルダへ移動する（vuls report で実施済み）
	# mv Vuls-Report-*.txt $REPORTS
	
	echo
done

# メモ
# vuls report -format-one-line-text -lang ja -diff -format-json -cvss-over=7
# vuls report -format-full-text -lang ja -diff -format-json -cvss-over=7
# vuls tui
# sqlite3 ./cpe.sqlite3 'select cpe_uri from categorized_cpes' | peco
# sqlite3 ./cve.sqlite3 'select cve_id from cve_details' | peco

