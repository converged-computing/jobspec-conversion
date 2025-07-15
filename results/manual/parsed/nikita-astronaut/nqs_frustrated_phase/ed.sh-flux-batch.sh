#!/bin/bash
#FLUX: --job-name=hairy-house-6387
#FLUX: --priority=16

conda activate tcm-test
pushd "/zfs/hybrilit.jinr.ru/user/a/astrakh/nqs_frustrated_phase/data/square/24/$1"
/zfs/hybrilit.jinr.ru/user/a/astrakh/HPhi.build/src/HPhi -e namelist.def 2>&1 | tee stdout.txt
popd
