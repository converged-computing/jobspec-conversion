#!/bin/bash
#FLUX: --job-name=astute-milkshake-0757
#FLUX: -t=72000
#FLUX: --urgency=16

module load anaconda/3/2021.11
source activate /u/atya/conda-envs/tf-gpu4
time srun python single_index_predict_z_with_pvol.py --job_id $SLURM_JOB_ID --model_type attention --trial_index 853 --snr_group 1 --max_seconds 71500 > logs/output.train.$SLURM_JOB_ID
