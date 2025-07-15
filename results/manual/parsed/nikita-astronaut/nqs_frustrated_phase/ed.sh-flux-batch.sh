#!/bin/bash
#FLUX: --job-name=blank-chip-5581
#FLUX: -c=32
#FLUX: --urgency=16

conda activate tcm-test
pushd "/zfs/hybrilit.jinr.ru/user/a/astrakh/nqs_frustrated_phase/data/square/24/$1"
/zfs/hybrilit.jinr.ru/user/a/astrakh/HPhi.build/src/HPhi -e namelist.def 2>&1 | tee stdout.txt
popd
