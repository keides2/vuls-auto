#!/bin/bash

# config.toml を使ってスキャン(vuls scan)とレポート(vuls report)を実行し、メールが送信されるかテストするスクリプト
# $1 FORMAT: full = -format-full-text, one = -format-one-line-text
# $2 DIFF: diff = -diff
# $3 project-name

if [ $# -ne 3 ]
then
	echo "    Usage: $ ./vuls-test.sh FORMAT OUTPUT PROJECT"
	echo "           FORMAT:  full | one"
	echo "           OUTPUT:  full | diff"
	echo "           PROJECT: e.g. Project-A"
	exit
fi

# define
ARG1="$1"
ARG2="$2"
ARG3="$3"
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

PROJECT=${ARG3}

echo "Format: ""$FORMAT"
echo "Diff: ""$DIFF"
echo "Project: ""$PROJECT"
echo "Today: ""$TODAY"
echo "Output: ""Vuls-Report"$FORMAT"-"$TODAY$DIFF".txt"

# ホームディレクトリに移動
cd
pwd

# フォルダーとファイルの定義
CONFIG="/home/vuls/config/$PROJECT/config.toml"
CONFIG_TEST="/home/vuls/config/$PROJECT/config.test.toml"
RESULTS_TEST="/home/vuls/results-test/$PROJECT"
REPORTS_TEST="/home/vuls/reports-test/$PROJECT"
LOGDIR="/var/log/vuls/$PROJECT"

# テスト用
mkdir -p ${RESULTS_TEST}
mkdir -p ${REPORTS_TEST}

# config.toml からテスト用 config.test.toml の作成
LINE=`sed -n '/email/=' $CONFIG`
sed $LINE,'$d' $CONFIG > config.test
cat config.test config.email > $CONFIG_TEST

# 検出 scan ～ レポート report
echo
echo "Vuls Scanning ["$PROJECT"] starts..."
vuls scan -config=$CONFIG -results-dir=$RESULTS_TEST -log-dir=$LOGDIR

# レポート
echo
echo "Vuls Reporting ["$PROJECT"] starts..."
vuls report -format-json $FORMAT -lang ja $DIFF -config=$CONFIG_TEST -results-dir=$RESULTS_TEST -log-dir=$LOGDIR -to-email > "$REPORTS_TEST/Vuls-Report-["$PROJECT"]"$FORMAT"-"$TODAY$DIFF".txt"
echo
