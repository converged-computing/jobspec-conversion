#!/bin/bash
#FLUX: --job-name=crunchy-animal-6035
#FLUX: --exclusive
#FLUX: --urgency=16

module purge
source /share/apps/anaconda/3-2019.03/etc/profile.d/conda.sh
conda activate condagw3
module load rocks-openmpi_ib
time python sim_nsbh_analysis.py $SLURM_ARRAY_TASK_COUNT $SLURM_ARRAY_TASK_ID
