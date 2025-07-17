#!/bin/bash
#FLUX: --job-name=expressive-destiny-8874
#FLUX: -t=259200
#FLUX: --urgency=16

module load intel/2016.4 python/3.7.0 scipy-stack/2019a
cd /project/def-jemerson/$USER/chflow
./chflow.sh 12_06_2020_22_26_12 ${SLURM_ARRAY_TASK_ID}
