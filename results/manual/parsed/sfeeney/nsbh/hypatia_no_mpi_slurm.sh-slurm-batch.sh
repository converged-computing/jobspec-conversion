#!/bin/bash
#FLUX: --job-name=nsbh
#FLUX: --exclusive
#FLUX: --queue=CORES24
#FLUX: --urgency=16

module purge
source /share/apps/anaconda/3-2019.03/etc/profile.d/conda.sh
conda activate condagw3
module load rocks-openmpi_ib
time python sim_nsbh_analysis.py $SLURM_ARRAY_TASK_COUNT $SLURM_ARRAY_TASK_ID
