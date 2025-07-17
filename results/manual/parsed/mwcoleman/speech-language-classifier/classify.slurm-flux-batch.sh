#!/bin/bash
#FLUX: --job-name=persnickety-eagle-8084
#FLUX: --queue=gpgpu
#FLUX: -t=432000
#FLUX: --urgency=16

module load gcccore/8.3.0
module load python/3.7.4
module purge
module load fosscuda/2019b
module load tensorflow/2.1.0-python-3.7.4
module load  python/3.7.4
cd ~/sounds
python model.py  ${OPTS} &> model${VAR}.log
