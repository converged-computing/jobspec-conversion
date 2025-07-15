#!/bin/bash
#FLUX: --job-name=vqe_passive_energy
#FLUX: --urgency=16

module load ruse
source /home/t/tuan-hoang/miniconda3/etc/profile.d/conda.sh
conda activate mlenv
ruse -s --label=${SLURM_ARRAY_TASK_ID} python rxx_vqe_noisy.py ${SLURM_ARRAY_TASK_ID}
