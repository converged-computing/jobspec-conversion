#!/bin/bash
#FLUX: --job-name=train
#FLUX: -t=172800
#FLUX: --urgency=16

export TF_CPP_MIN_LOG_LEVEL='2'

export TF_CPP_MIN_LOG_LEVEL="2"
module load python/3.10.9-fasrc01
module load cuda/12.2.0-fasrc01
module load gcc/12.2.0-fasrc01
module load openmpi/4.1.4-fasrc01
mamba activate jax
cd /n/holystore01/LABS/iaifi_lab/Users/smsharma/set-diffuser/
python -u infer.py --seed $SLURM_ARRAY_TASK_ID --n_steps 50 --n_elbo_samples 8 --n_test 32 --run_name "gallant-cherry-87"
python -u infer.py --seed $SLURM_ARRAY_TASK_ID --n_steps 50 --n_elbo_samples 8 --n_test 32 --run_name "magical-goosebump-109"
