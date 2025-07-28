#!/bin/bash
#FLUX: --job-name=eccentric-malarkey-8962
#FLUX: -t=43200
#FLUX: --urgency=16

module load intel python scipy-stack
cd /project/def-jemerson/pavi/chflow
./chflow.sh 19_06_2020_12_06_16 ${SLURM_ARRAY_TASK_ID}
