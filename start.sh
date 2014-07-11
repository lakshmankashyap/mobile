#!/bin/sh

root=~/prod/mobile

cd ${root}
export PORT=8005
/usr/bin/npm start >>${root}/stdout.log 2>&1