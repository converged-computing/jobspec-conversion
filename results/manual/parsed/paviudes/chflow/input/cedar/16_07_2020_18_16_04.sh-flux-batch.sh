#!/bin/bash
#FLUX: --job-name=anxious-general-0115
#FLUX: -t=10800
#FLUX: --urgency=16

module load intel/2016.4 python/3.7.0 scipy-stack/2019a
cd /project/def-jemerson/a77jain/chflow
./chflow.sh 16_07_2020_18_16_04 ${SLURM_ARRAY_TASK_ID}
