#!/bin/bash
#FLUX: --job-name="Impact_Pretraining_CodeT5_Large"
#FLUX: -t=34200
#FLUX: --priority=16

module purge all
module load multigpu
module load mamba
source ~/miniconda3/bin/activate
conda activate /home/ppooja/data/conda/envs/shirin-codet5
wandb login <your-auth-key>
srun ./sh/pre-train.sh
