#!/bin/bash
# Usage: $ ./versions.sh > versions-20210115-CentOS7.txt 2>&1

# CentOS Linux release 7.3.1611 (Core)
echo ・OS:
cat /etc/redhat-release
echo

# SQLite version 3.7.17 2013-05-20 00:56:22
echo ・SQLite3:
sqlite3 -version
echo

# git version 2.9.3
echo ・Git:
git --version
echo

# gcc バージョン 4.8.5 20150623 (Red Hat 4.8.5-39) (GCC)
echo ・GCC:
gcc -v
echo

# GNU Make 3.82
echo ・GNU make:
make -v
echo

# GNU Wget 1.14 built on linux-gnu.
echo ・wget:
wget -V
echo

# yum-utils 3.4.3
echo ・yum:
yum --version
echo

# go version go1.13.8 linux/amd64
echo ・GO:
go version
echo

# go-cpe-dictionary
echo ・go-cpe-dictionary:
go-cpe-dictionary -v
echo

# go-cve-dictionary v0.4.1 4a02438
echo ・go-cve-dictionary:
go-cve-dictionary -v
echo

# goval-dictionary v0.2.4 85c5c09
echo ・goval-dictionary:
goval-dictionary -v
echo

# gost 76d68fe
echo ・gost:
gost -v
echo

# go-exploitdb
echo ・go-exploitdb:
go-exploitdb -v
echo

# vuls v0.9.1 build-20200217_101021_00e52a8
echo ・Vuls:
vuls -v
echo

# peco version v0.5.3 (built with go1.10)
echo ・peco:
peco --version
echo

# su from util-linux 2.23.2
echo ・su:
su -V
echo

# Sudo バージョン 1.8.6p7
# sudoers ポリシープラグイン バージョン 1.8.6p7
# sudoers ファイル⽂法バージョン 42
# Sudoers I/O plugin version 1.8.6p7
echo ・sudo:
sudo -V
echo
