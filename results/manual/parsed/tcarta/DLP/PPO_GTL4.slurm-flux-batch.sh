#!/bin/bash
#FLUX: --job-name=PPO_GTL4_%a
#FLUX: -c=20
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load python/3.8.2
conda activate dlp
srun scripts/train_ppo_baseline.sh BabyAI-GoToLocalS8N4-v0 GTL4 6 ${SLURM_ARRAY_TASK_ID}
