#!/bin/bash
#FLUX: --job-name=persnickety-buttface-2411
#FLUX: -t=10800
#FLUX: --urgency=16

module load intel/2016.4 python/3.7.0 scipy-stack/2019a
cd /project/def-jemerson/pavi/chflow
./chflow.sh 16_07_2020_18_08_08 ${SLURM_ARRAY_TASK_ID}
