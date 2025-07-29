#!/bin/bash
#SBATCH --job-name=emb
#SBATCH --output=embo.txt
#SBATCH --error=embe.txt
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

module load cuda/10.1
source $HOME/programs/anaconda3/bin/activate
conda activate SUMMA
srun python pretrain_develop.py \
    --checkpoint-activations \
    --distribute-checkpointed-activations \
    --master-port 2048 \
    --batch-size 96 \
    --hidden-size 2048 \
    --rank-rearrange
