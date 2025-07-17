#!/bin/bash
#FLUX: --job-name=expressive-animal-6273
#FLUX: -c=32
#FLUX: --queue=dgx
#FLUX: -t=259200
#FLUX: --urgency=16

conda activate tcm-test
pushd "/zfs/hybrilit.jinr.ru/user/a/astrakh/nqs_frustrated_phase/data/square/24/$1"
/zfs/hybrilit.jinr.ru/user/a/astrakh/HPhi.build/src/HPhi -e namelist.def 2>&1 | tee stdout.txt
popd
