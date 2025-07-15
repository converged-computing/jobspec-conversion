#!/bin/bash
#FLUX: --job-name=PPO_GTRB_%a
#FLUX: -c=20
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load python/3.8.2
conda activate dlp
srun scripts/train_ppo_baseline.sh BabyAI-GoToRedBallNoDists-v0 GTRB 6 ${SLURM_ARRAY_TASK_ID}
