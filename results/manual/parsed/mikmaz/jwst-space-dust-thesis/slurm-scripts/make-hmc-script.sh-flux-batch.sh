#!/bin/bash
#FLUX: --job-name=fat-noodle-5252
#FLUX: -c=5
#FLUX: -t=223200
#FLUX: --urgency=16

cat <<EoF
hostname
echo "$CUDA_VISIBLE_DEVICES"
python3 -u posterior_samples.py ../data/full $1/01 $2 $3 $4 &
python3 -u posterior_samples.py ../data/full $1/02 $2 $3 $4 &
python3 -u posterior_samples.py ../data/full $1/03 $2 $3 $4 &
python3 -u posterior_samples.py ../data/full $1/04 $2 $3 $4 &
python3 -u posterior_samples.py ../data/full $1/05 $2 $3 $4 &
wait
EoF
