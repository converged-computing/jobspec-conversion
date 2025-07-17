#!/bin/bash
#FLUX: --job-name=purple-bike-0993
#FLUX: -t=43200
#FLUX: --urgency=16

module load intel/2016.4 python/3.7.0 scipy-stack/2019a
cd /project/def-jemerson/pavi/chflow
./chflow.sh 16_07_2020_18_17_53 ${SLURM_ARRAY_TASK_ID}
