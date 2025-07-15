#!/bin/bash
#FLUX: --job-name=PPO_GTL_a12_%a
#FLUX: -c=20
#FLUX: -t=36000
#FLUX: --priority=16

module purge
module load python/3.8.2
conda activate dlp
srun scripts/train_ppo_baseline.sh BabyAI-GoToLocal-v0 GTL 12 ${SLURM_ARRAY_TASK_ID}
