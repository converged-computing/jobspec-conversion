#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=/misc/vlgscratch4/BrunaGroup/rj1408/nlu/ptb_wsj_pos/models/test/a/train_logs.out
#SBATCH --error=/misc/vlgscratch4/BrunaGroup/rj1408/nlu/ptb_wsj_pos/models/test/a/train_logs.err
#SBATCH --mail-user=rj1408@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8GB
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=lion3,lion17

module purge
module load cuda/9.0.176
eval "$(conda shell.bash hook)"
conda activate dgl_env
srun python3 LM_LatentVariable.py --dataroot /misc/vlgscratch4/BrunaGroup/rj1408/nlu/ptb_wsj_pos/ \
    --batchSize 64 --outf /misc/vlgscratch4/BrunaGroup/rj1408/nlu/ptb_wsj_pos/models/test/a/ \
    --cuda
