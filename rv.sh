#!/bin/bash
set -x 

json_out=`pwd`/errors.json
report_out=`pwd`/report

apt install -y automake libtool make python zlib1g-dev

autoreconf -f -i
./configure --disable-silent-rules CC=kcc LD=kcc CFLAGS="-fissue-report=$json_out"
make -j`nproc`
make -C tests check

touch $json_out && rv-html-report $json_out -o $report_out
rv-upload-report $report_out
