#!/bin/bash
#FLUX: --job-name="Partitioning of images"
#FLUX: --queue=CPUQ
#FLUX: -t=43200
#FLUX: --priority=16

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR} # /cluser/work/<username>/master-sau/slurm
uname -a
module purge
module load Python/3.8.6-GCCcore-10.2.0
cd ..
cd preprocessing
pwd
python -u transform.py
