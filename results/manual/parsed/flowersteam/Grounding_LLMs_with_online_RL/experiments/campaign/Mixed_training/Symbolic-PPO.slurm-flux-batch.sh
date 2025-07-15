#!/bin/bash
#FLUX: --job-name=Symbolic-PPO_seed_%a
#FLUX: -c=20
#FLUX: -t=36000
#FLUX: --priority=16

module purge
module load python/3.8.2
conda activate dlp
srun experiments/slurm/train_symbolic_ppo.sh BabyAI-MixedTrainLocal-v0 MTRL 6 ${SLURM_ARRAY_TASK_ID}
