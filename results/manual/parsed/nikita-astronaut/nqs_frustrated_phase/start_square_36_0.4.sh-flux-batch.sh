#!/bin/bash
#FLUX: --job-name=square_qua_phase_36_dense_0.4
#FLUX: --priority=16

start=$(date +%s)
python3 /zfs/hybrilit.jinr.ru/user/a/astrakh/nqs_frustrated_phase/generalisation_very_large.py /zfs/hybrilit.jinr.ru/user/a/astrakh/nqs_frustrated_phase/config_square_phase_K_0.4
finish=$(date +%s)
echo $[$finish-$start]
